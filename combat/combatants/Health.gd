extends Node

signal dead
signal health_changed(life)

var life = 0
var max_life = 0
var base_armor = 0
var armor = 0

func _ready():
	armor = base_armor


func take_damage(damage):
	life = life - damage + armor
#	print(life)
	if life <= 0:
		life=0
		emit_signal("health_changed", 0)
		emit_signal("dead")
	else:
		emit_signal("health_changed", life)


func heal(amount):
	life += amount
	life = clamp(life, life, max_life)
	emit_signal("health_changed", life)


func get_health_ratio():
	return life / max_life
