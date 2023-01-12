extends PanelContainer

var ui_node

func _ready():
	$TouchScreenButton.modulate = 0
	ui_node = get_parent().get_parent().get_parent()	
	
func find_sprite(givenlabel):
	for hero_sprite in ui_node.get_node("HeroSprite").get_children():
		if givenlabel == hero_sprite.get_node("Label").text:
			return hero_sprite
	
func _on_TouchScreenButton_pressed():
	$TouchScreenButton.modulate = 170
	var find = get_node("HSplitContainer/VBoxContainer/Name").text
	var hero_node = find_sprite(find)
	var opp_node = ui_node.get_node("OppSprite").hero_alive()[0]
	hero_node.attack(opp_node)

func readytofight():
	$TouchScreenButton.modulate = 0
