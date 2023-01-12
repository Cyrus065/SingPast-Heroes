extends Combatant

var target=[]

func set_active(value):
	.set_active(value)
	if not active:
		return

	if not $Timer.is_inside_tree():
		return
	$Timer.start()
	yield($Timer, "timeout")
	
	target.clear()
	for actor in get_parent().get_parent().get_node("HeroSprite").get_children():
		if actor.get_node("Health").life > 0:
			target.append(actor)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randi_range(0, target.size()-1)#supposed to be +1
	if target.size() != 0:
		attack(target[my_random_number])
