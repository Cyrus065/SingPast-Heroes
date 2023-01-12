extends Node

export(NodePath) var exploration_screen

var quest_filepath = "res://quest/Quest_1965.json"
var heros_filepath = "res://heros/Heros_1965.json"
var allquests:AllQuests
var allitems: AllItems
var allphotos
var allheros: AllHeros
var allmyheros: AllHeros
var chosenheros:AllHeros

var year:int = 1965
var money:float = 0
var location:String = "City Hall"

func _ready():
	var file = File.new()
	if file.file_exists(quest_filepath):
		file.open(quest_filepath, file.READ)
		var quest_list = parse_json(file.get_as_text())
		#read file into text
		
		var quest_array=[]
		for quest_code in quest_list:
			var quest = Quest.new(quest_code,quest_list[quest_code])
			quest_array.append(quest)
		allquests = AllQuests.new(quest_array)
		#convert .json into quest and into allquests
	
	var file1 = File.new()
	if file1.file_exists(heros_filepath):
		file1.open(heros_filepath, file1.READ)
		var heros_list = parse_json(file1.get_as_text())
		#read file into text
		
		var heros_array=[]
		for heros_code in heros_list:
			var hero = Hero.new(heros_code,heros_list[heros_code])
			heros_array.append(hero)
		allheros = AllHeros.new(heros_array)
		
	var file2 = File.new()
	if file2.file_exists(heros_filepath):
		file2.open("res://heros/MyHeros.json", file1.READ)
		var my_heros_list = parse_json(file2.get_as_text())

		var my_heros=[]
		for heros_code in my_heros_list:
			var myhero = allheros.codeForHero(heros_code)
			myhero.gotNewHero(my_heros_list[heros_code])
			my_heros.append(myhero)
		allmyheros = AllHeros.new(my_heros)
#		print(allmyheros._showAll())
		#convert .json into quest and into allquests
	
	var item_array=[]
	allitems = AllItems.new(item_array)
	
	allphotos=[]


func _choose_dialogue(character_name):
	var extention = "_default.json"
	var dialogue_string = "/"+character_name+extention
		
	if character_name == "Mum":
		if allquests._getQuest("1965.1").unlocked == false:
			dialogue_string = "res://dialogue/dialogue_data/Mum_1965.1.json"

		elif allquests._getQuest("1965.1").fulfilled == true and allquests._getQuest("1965.1").claimed == false:
			dialogue_string = "res://dialogue/dialogue_data/Mum_1965.1(1).json"
			
		else:
			dialogue_string = "res://dialogue/dialogue_data/Mum_default.json"

	elif character_name == "Uncle Lee":
		
		if allquests._getQuest("1965.1").assigned == true and allquests._getQuest("1965.1").fulfilled == false:
			dialogue_string = "res://dialogue/dialogue_data/Uncle Lee_1965.1.json"

		else:
			dialogue_string = "res://dialogue/dialogue_data/Uncle Lee_default.json"
	
	elif character_name == "Brother":
		if allquests._getQuest("1965.2").unlocked == true and allquests._getQuest("1965.2").assigned == false:
			dialogue_string = "res://dialogue/dialogue_data/Brother_1965.2.json"
		elif allitems._hasItem("Ice Kachang") == true and allquests._getQuest("1965.2").fulfilled == false and allquests._getQuest("1965.2").claimed == false:
			dialogue_string = "res://dialogue/dialogue_data/Brother_1965.2(2).json"
		else:
			dialogue_string = "res://dialogue/dialogue_data/Brother_default.json"

	elif character_name == "Sister":
		if allquests._getQuest("1965.3").unlocked == true and allquests._getQuest("1965.3").assigned ==false:
			dialogue_string = "res://dialogue/dialogue_data/Sister_1965.3.json"
		elif allphotos.size() > 0 and allquests._getQuest("1965.3").fulfilled == false and allquests._getQuest("1965.3").claimed == false:
			dialogue_string = "res://dialogue/dialogue_data/Sister_1965.3(2).json"
		else:
			dialogue_string = "res://dialogue/dialogue_data/Sister_default.json"

	elif character_name == "Orchard Theatre Employee":
		if allquests._getQuest("1965.3").assigned == true and allquests._getQuest("1965.3").claimed == false: 
			dialogue_string = "res://dialogue/dialogue_data/Orchard Theatre Employee_1965.3.json"
		else:
			dialogue_string = "res://dialogue/dialogue_data/Orchard Theatre Employee_default.json"

	elif character_name == "LeeKuanYew":
		dialogue_string = "res://dialogue/dialogue_data/LeeKuanYew_default.json"
		
	elif character_name == "Farmer":
		dialogue_string = "res://dialogue/dialogue_data/Farmer_default.json"	
		
	elif character_name == "Gangster":
		dialogue_string = "res://dialogue/dialogue_data/Gangster_default.json"
				
	elif character_name == "Book":
		dialogue_string = "res://dialogue/dialogue_data/Book_default.json"
		
	elif character_name == "Opponent":
		dialogue_string = "res://dialogue/dialogue_data/Opponent_default.json"
	
			
	elif character_name == "Object":
		dialogue_string = "res://dialogue/dialogue_data/Object_default.json"
	
	elif character_name == "Ice Kachang Man":
			dialogue_string = "res://dialogue/dialogue_data/Ice Kachang Man_default.json"	
	
	elif character_name == "Dad":
		dialogue_string = "res://dialogue/dialogue_data/Dad_default.json"
		
		
	else:
		dialogue_string = null
	
	return dialogue_string

#1965 historic events:
#06 01 1965: The Orchard Theatre was opened
#10 03 1965: Macdonald's House Bombing
#09 05 1965: Formation of Malaysian Solidarity Convention
#10 07 1965: People's Action Party vs Barisan Sosialis
#09 08 1965: Singapore was expelled by Malaysia
#09 08 1965: MID and MFA was formed
#09 08 1965: Merger to form Radio & Television Singapura
#21 09 1965: Singapore was admitted into United Nations
#15 10 1965: Singapore was admitted into Commonwealth
#15 10 1965: Singapore Conference Hall was opened 
#27 11 1965: First underground carpark was opened
#08 12 1965: First sitting of Parliament of Singapore
#14 12 1965: Southeast Asian Peninsular Games
#22 12 1965: Constitutional Amendment Act was passed
#23 12 1965: The Singapore Army Act was passed
#30 12 1965: The People's Defense Force Act was passed

