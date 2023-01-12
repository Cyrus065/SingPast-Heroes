extends Node

export(NodePath) var combat_screen
export(NodePath) var exploration_screen
export(NodePath) var farm_screen
export(NodePath) var bookshelf_screen
export(NodePath) var house_screen
var active_screen

const PLAYER_WIN = "res://dialogue/dialogue_data/player_won.json"
const PLAYER_LOSE = "res://dialogue/dialogue_data/player_lose.json"

func _ready():
	$AudioStreamPlayer.play()
	
	exploration_screen = get_node(exploration_screen)
	combat_screen = get_node(combat_screen)
	farm_screen = get_node(farm_screen)
	house_screen = get_node(house_screen)
	bookshelf_screen = get_node(bookshelf_screen)
	
	combat_screen.connect("combat_finished", self, "_on_combat_finished")
	
	for n in $House/Grid.get_children():
		if not n.type == n.CellType.ACTOR:
			continue
		if not n.has_node("DialoguePlayer"):
			continue
		n.get_node("DialoguePlayer").connect("dialogue_finished", self,
			"_on_opponent_dialogue_finished", [n])
			
	for n in $House/Grid.get_children():
		if not n.type == n.CellType.KEY_CHARACTER:
			continue
		if not n.has_node("DialoguePlayer"):
			continue
		n.get_node("DialoguePlayer").connect("dialogue_finished", self,
			"open_bookshelf")
				
	for n in $Exploration/Grid.get_children():
		if not n.type == n.CellType.ACTOR:
			continue
		if not n.has_node("DialoguePlayer"):
			continue
		n.get_node("DialoguePlayer").connect("dialogue_finished", self,
			"_on_opponent_dialogue_finished", [n])
	
	for n in $Exploration/Grid.get_children():
		if not n.type == n.CellType.KEY_CHARACTER:
			continue
		if not n.has_node("DialoguePlayer"):
			continue
#		n.get_node("DialoguePlayer").connect("dialogue_finished", self,
#			"_on_opponent_dialogue_finished", [n])
		n.get_node("DialoguePlayer").connect("dialogue_finished", self,
			"open_farm")

	active_screen = house_screen
	remove_child(combat_screen)
	remove_child(farm_screen)
	remove_child(house_screen)
	remove_child(exploration_screen)
	remove_child(bookshelf_screen)
	add_child(house_screen)

	
func open_farm():
	remove_child(exploration_screen)
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	add_child(farm_screen)
	farm_screen.show()
	$AnimationPlayer.play_backwards("fade")
	
func open_bookshelf():
	remove_child(house_screen)
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	add_child(bookshelf_screen)
	bookshelf_screen.show()
	$AnimationPlayer.play_backwards("fade")	
	
func start_combat(combat_actors):
	$AudioStreamPlayer.stream_paused=true
	$AudioStreamPlayer.stream=load("res://Cyrus/in-search-of-asia.mp3")
	$AudioStreamPlayer.stream_paused=false	
	$AudioStreamPlayer.play()
	
	remove_child(exploration_screen)
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	add_child(combat_screen)
	combat_screen.show()
	combat_screen.initialize(combat_actors)
	$AnimationPlayer.play_backwards("fade")


func _on_opponent_dialogue_finished(opponent):
#	print(opponent)
	if opponent.lost:
		return
	var player = $Exploration/Grid/Player
	var combatants = [player, opponent]
	start_combat(combatants)


func _on_combat_finished(winner, _loser):
	$AudioStreamPlayer.stream_paused=true
	$AudioStreamPlayer.stream=load("res://Cyrus/audio_hero_Into-The-Sunset_SIPML_T-0310.mp3")
	$AudioStreamPlayer.stream_paused=false
	$AudioStreamPlayer.play()	
	
	combat_screen.clear_combat()
	remove_child(combat_screen)
	add_child(exploration_screen)
	$AnimationPlayer.play_backwards("fade")

	var dialogue = load("res://dialogue/dialogue_player/DialoguePlayer.tscn").instance()
	if winner == "Player":
		dialogue.dialogue_file = PLAYER_WIN
		if Main.allquests._getQuest("1965.1").assigned == true and Main.allquests._getQuest("1965.1").fulfilled == false:
			dialogue.dialogue_file = "res://dialogue/dialogue_data/Uncle Lee_1965.1(1).json"
	else:
		dialogue.dialogue_file = PLAYER_LOSE
	yield($AnimationPlayer, "animation_finished")
	var player = $Exploration/Grid/Player
	exploration_screen.get_node("CanvasLayer/DialogueUI").show_dialogue(player, dialogue)
	yield(dialogue, "dialogue_finished")
	dialogue.queue_free()

func _on_Farm_close_farm():
	remove_child(farm_screen)
	add_child(exploration_screen)
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer, "animation_finished")
	
	var dialogue = load("res://dialogue/dialogue_player/DialoguePlayer.tscn").instance()
	var player = $Exploration/Grid/Player
	dialogue.dialogue_file = "res://dialogue/dialogue_data/Farmer_bye.json"
	exploration_screen.get_node("CanvasLayer/DialogueUI").show_dialogue(player, dialogue)

func _on_Bookshelf_close_bookshelf():
	remove_child(bookshelf_screen)
	add_child(house_screen)
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer, "animation_finished")

func took_picture():
	var dialogue = load("res://dialogue/dialogue_player/DialoguePlayer.tscn").instance()
	var player
	if active_screen == exploration_screen:
		player = $Exploration/Grid/Player
	elif active_screen == house_screen:
		player = $House/Grid/Player
	dialogue.dialogue_file = "res://dialogue/dialogue_data/Player_took_picture.json"
	active_screen.get_node("CanvasLayer/DialogueUI").show_dialogue(player, dialogue)

func _hide_controls():
	active_screen.get_node("CanvasLayer")._hide_controls()

func _show_controls():
	active_screen.get_node("CanvasLayer")._show_controls()

func _on_House_go_exploration():
	remove_child(house_screen)
	add_child(exploration_screen)
	$Exploration/Grid/Player/Camera2D.make_current()
	$AnimationPlayer.play_backwards("fade")
	active_screen = exploration_screen


func _on_Exploration_go_house():
	remove_child(exploration_screen)
	add_child(house_screen)
	$House/Grid/Player/Camera2D.make_current()
	$AnimationPlayer.play_backwards("fade")
	active_screen = house_screen
