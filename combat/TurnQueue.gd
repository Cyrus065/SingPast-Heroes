extends Node
var hero_combatants_list
var opp_combatants_list

var queue=[]
var hero0_attacked:bool
var hero1_attacked:bool
var active_combatant = null setget _set_active_combatant

signal active_combatant_changed(active_combatant)

func initialize():
	hero_combatants_list = get_parent().get_node("UI/HeroSprite")
	opp_combatants_list = get_parent().get_node("UI/OppSprite")
	set_queue(hero_combatants_list,opp_combatants_list)
	play_turn()

func play_turn():
	yield(active_combatant, "turn_finished")
	get_next_in_queue()
	play_turn()


func get_next_in_queue():
	var current_combatant = queue.pop_front()
	current_combatant.active = false
	queue.append(current_combatant)
	self.active_combatant = queue[0]
	return active_combatant


func remove(combatant):
	var new_queue = []
	for n in queue:
		new_queue.append(n)
	new_queue.remove(new_queue.find(combatant))
	combatant.queue_free()
	self.queue = new_queue

func set_queue(hero_queue,opp_queue):
	queue.clear()
	hero_queue.active=false
	opp_queue.active=false
	queue.append(hero_queue)
	queue.append(opp_queue)
#	print(queue)
	if queue.size() > 0:
		self.active_combatant = queue[0]


func _set_active_combatant(new_combatant):
	active_combatant = new_combatant
	active_combatant.active = true
	emit_signal("active_combatant_changed", active_combatant)
	
	if(active_combatant==hero_combatants_list):
		var hero_info = get_parent().get_node("UI/VSplitContainer/Combatants").get_children()
		for each in hero_info:
			each.readytofight()
