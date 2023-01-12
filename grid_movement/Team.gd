extends Node

export(String) var hero1_code
export(String) var hero2_code
export(String) var hero3_code
export(String) var hero4_code
export(String) var hero5_code
export(String) var hero6_code

var team = []

func _ready():
	team.append(hero1_code)
	team.append(hero2_code)
	team.append(hero3_code)
	team.append(hero4_code)
	team.append(hero5_code)
	team.append(hero6_code)
