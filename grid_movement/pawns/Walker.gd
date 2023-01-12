extends Pawn

onready var parent = get_parent()
#warning-ignore:unused_class_variable
export(PackedScene) var combat_actor
#warning-ignore:unused_class_variable
var lost = false
var move_time = 0.15

func _ready():
	update_look_direction(Vector2.DOWN)


func _process(_delta):
	var input_direction = get_input_direction()
#	if not input_direction:
#		return
	var res = Input.get_action_strength("ui_run")
	if res == 1.0:
		move_time=0.15
	else:
		move_time=0.25
	
	update_look_direction(input_direction)

	var target_position = parent.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
		$Tween.start()
	else:
		bump()


func get_input_direction():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)


func update_look_direction(direction):
	if direction == Vector2(0,0):
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position",direction)
		$AnimationTree.set("parameters/Walk/blend_position",direction)
		
#up: (0,-1)
#down: (0,1)
#left:(-1,0)
#right:(1,0)


func move_to(target_position):
	set_process(false)
#	$AnimationPlayer.play("walk")
	var move_direction = (position - target_position).normalized()
	$Tween.interpolate_property($Sprite, "position", move_direction, Vector2(), move_time, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$Sprite.position = $Sprite.position - target_position
	position = target_position
	yield(get_tree().create_timer(move_time), "timeout")
#
#	yield($AnimationPlayer, "animation_finished")

	set_process(true)


func bump():
#	$AnimationPlayer.play("bump")
	pass
