extends Node

var heroes:int
var fainted_heroes = 0

export(PackedScene) var hero_scene
export(PackedScene) var opp_scene

signal combat_finished(winner, loser)

func initialize(combat_combatants):
	var hero = hero_scene.instance()
	$UI.add_child(hero)
	
	var opp = opp_scene.instance()
	$UI.add_child(opp)
	
	$UI.initialize(combat_combatants)
	$TurnQueue.initialize()
	$UI/HeroSprite.initialize()
	$UI/OppSprite.initialize()
	heroes = Main.allmyheros.heroarray.size()
	fainted_heroes=0
	
#	var combatant_sprite = $UI/OppSprite.get_node("Opponent")
#	combatant_sprite.get_node("Health").connect("dead", self, "_on_combatant_death", [combatant_sprite])
	
	for combatant_sprite in $UI/OppSprite.get_children():
		combatant_sprite.get_node("Health").connect("dead", self, "_on_combatant_death", [combatant_sprite])	
	
	for hero_sprite in $UI/HeroSprite.get_children():
		hero_sprite.get_node("Health").connect("dead", self, "_on_combatant_death", [hero_sprite])

func clear_combat():
	for n in $UI/VSplitContainer/Combatants.get_children():
		n.queue_free()
	$UI/HeroSprite.queue_free()
	$UI/OppSprite.queue_free()
	for n in $UI/VSplitContainer.get_children():
		if n is PanelContainer:
			n.queue_free()

func finish_combat(winner, loser):
	emit_signal("combat_finished", winner, loser)

func find_info(givenlabel):
	for hero_info in $UI/VSplitContainer/Combatants.get_children():
		if givenlabel == hero_info.get_node("HSplitContainer/VBoxContainer/Name").text:
			return hero_info

func _on_combatant_death(combatant):
#	print(combatant.get_parent()==get_node("UI/OppSprite"))
#	print($UI/OppSprite.hero_alive())

	var winner
	var loser
	
	if($UI/OppSprite.hero_alive().size() == 0):
		winner="Player"
		loser="Opponent"
		finish_combat(winner, loser)
	elif($UI/HeroSprite.hero_alive().size() == 0):
		loser="Player"
		winner="Opponent"
		finish_combat(winner, loser)
	
	elif(combatant.get_parent()==get_node("UI/HeroSprite")):
		combatant.visible=false
		fainted_heroes=fainted_heroes+1
		var name = combatant.get_node("Label").text
		var info = find_info(name)
		info.get_node("TouchScreenButton").visible =false
		info.get_node("Panel/Label").text="Fainted"
		info.get_node("Panel").visible=true
		
	elif(combatant.get_parent()==get_node("UI/OppSprite")):
		combatant.visible=false
		get_node("UI").update_opp_info(6-$UI/OppSprite.hero_alive().size())
		
#	if fainted_heroes == heroes:
#		var winner
#		var loser
#		if not combatant.name == "Player":
#	#		winner = $Combatants/Player
#			winner = $UI/HeroSprite.get_child(0)
#		else:
#			for n in $Combatants.get_children():
#				if not n.name == "Player":
#					winner = n
#					break
#		##player always win, need change
#		winner.name="Player"
#	#	print(winner.name)
#		fainted_heroes=0
		
		
#		combatant.queue_free()

