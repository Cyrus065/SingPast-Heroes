extends Node2D

var active = false setget set_active
var alive =[]
var attacked = []
var all_attacked = false
var result=[]

signal turn_finished

func initialize():
	for hero_sprite in get_children():
		hero_sprite.connect("attacked", self, "all_child_attacked")
		
func set_active(value):
	for each in get_children():
		if each.get_node("Health").life>0:
			each.set_active(value)

func all_child_attacked(hello):
	alive.clear()
	result.clear()
	for each in get_children():
		if each.get_node("Health").life >0:
			alive.append(each)
			
	attacked.append(hello)
	
	var k = 0
	for each in alive:
		result.append(attacked.has([alive[k]]))
		k=k+1

	if !result.has(false):
#		print(result)
		attacked.clear()
		all_attacked=false
		emit_signal("turn_finished")

func hero_alive():
	alive.clear()
	for each in get_children():
		if each.get_node("Health").life >0:
			alive.append(each)
	return alive
