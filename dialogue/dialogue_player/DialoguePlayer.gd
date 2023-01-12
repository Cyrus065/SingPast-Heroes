extends Node

#insert default dialogue into dialogue_file
#export(String, FILE, "*.json") var dialogue_file
#export(String,DIR) var dialogue_folder = "res://dialogue/dialogue_data/"
export(String) var character_name

var dialogue_file
var dialogue_folder = "res://dialogue/dialogue_data/"

var dialogue_keys = []
var dialogue_name = ""
var current = 0
var dialogue_text = ""

signal dialogue_started
signal dialogue_finished

func start_dialogue():
	var old = dialogue_file
	dialogue_file = Main._choose_dialogue(character_name)
	if dialogue_file == null:
		dialogue_file=old
	emit_signal("dialogue_started")
	current = 0
	index_dialogue()
	dialogue_text = dialogue_keys[current].text
	dialogue_name = dialogue_keys[current].name

func next_dialogue():
	current += 1
	if current == dialogue_keys.size():
		emit_signal("dialogue_finished")
		return
	dialogue_text = dialogue_keys[current].text
	dialogue_name = dialogue_keys[current].name
	
	if dialogue_name == "":
		if "Received" in dialogue_text:
			Main.money=Main.money+float(dialogue_text.split("$")[1].split(" from")[0])

		elif "Gave" in dialogue_text:
			Main.money=Main.money-float(dialogue_text.split("$")[1].split(" to")[0])

		elif "Unlocked" in dialogue_text:
			Main.allquests._getQuest(dialogue_text.split("objective ")[1].split(" by")[0])._unlock()
			
		elif "Assigned" in dialogue_text:
			Main.allquests._getQuest(dialogue_text.split("objective ")[1].split(" by")[0])._assign()
			
		elif "Fulfilled" in dialogue_text:
			Main.allquests._getQuest(dialogue_text.split("objective ")[1].split(" by")[0])._fulfill()
			
		elif "Claimed" in dialogue_text:
			Main.allquests._getQuest(dialogue_text.split("objective ")[1].split(" by")[0])._claim()
		
		elif "Obtained" in dialogue_text:
			Main.allitems._addItem(dialogue_text.split("item ")[1].split(" from")[0])

		elif "Passed" in dialogue_text:
			Main.allitems._minusItem(dialogue_text.split("item ")[1].split(" to")[0])
			
func index_dialogue():
	var dialogue = load_dialogue(dialogue_file)
	dialogue_keys.clear()
	for key in dialogue:
		dialogue_keys.append(dialogue[key])

func load_dialogue(file_path):
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		var dialogue = parse_json(file.get_as_text())
		return dialogue
	else:
		print(file_path + " DNE")
		return {"dialog_1":{"name":"","text":"file DNE"}}

#
#func play_straight():
#	pass
#
#func find_and_play():
#	pass
#
#func find_dialogue():
#		#dialogue_file = find_dialogue() in start_dialogue()
#	var folder = Directory.new()
#	folder.open(dialogue_folder)
#	var file = dir_contents(dialogue_folder)
#	var result = dialogue_folder + "/" +file
#	return result
#
#func dir_contents(path):
#	var dir = Directory.new()
#	if dir.open(path) == OK:
#		dir.list_dir_begin()
#		var file_name = dir.get_next()
#		while file_name != "":
#			if character_name in file_name:
#				return file_name
#			file_name = dir.get_next()
#	else:
#		print("An error occurred when trying to access the path.")
#		return null
