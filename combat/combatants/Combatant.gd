class_name Combatant
extends Node

var damage
var defense
var attacked = false
var active = false setget set_active

signal turn_finished
signal attacked

func _ready():
	if $Label.text!="":
		damage = $"/root/Main".allheros.nameForHero($Label.text).hero_atk
		defense = $"/root/Main".allheros.nameForHero($Label.text).hero_def

func set_active(value):
	active = value
	set_process(value)
	set_process_input(value)
	
	if not active:
		return

func attack(target):
	target.take_damage(damage*100)
	emit_signal("attacked",[self])

func reset():
	var hero_info = get_parent().get_parent().get_parent().find_info($Label.text)
	hero_info.get_node("TouchScreenButton").visible = true

func consume(item):
	item.use(self)
	emit_signal("turn_finished")


func defend():
	$Health.armor += defense
	emit_signal("turn_finished")


func flee():
	emit_signal("turn_finished")


func take_damage(damage_to_take):
	$DamageTaken.text=str(damage_to_take/defense)
	$DamageTaken.visible=true
	$Health.take_damage(damage_to_take/defense)
	$Sprite/AnimationPlayer.play("take_damage")
	yield($Sprite/AnimationPlayer, "animation_finished")	
	$DamageTaken.visible=false
