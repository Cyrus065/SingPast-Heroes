extends PanelContainer

var body_path = "res://heros/full_body/"
var type_path = "res://heros/type/"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if get_node("TouchScreenButton").is_pressed():
		var bag_node = get_parent().get_parent()
		var hero_code = get_node("Label").text
		var hero = Main.allmyheros.codeForHero(hero_code)
		var img_body = load(body_path+hero_code+".png")
		var img_type_icon = load(type_path+hero.hero_type+".png")
		var img_type_bg = load(type_path+hero.hero_type+"_bg.png")
		bag_node.get_node("Panel/UnitBody").texture = img_body
#		bag_node.get_node("Whitebackground2").visible = true
		bag_node.get_node("Panel/CharNameLabel").text = hero.hero_name
		bag_node.get_node("Panel/TypeIcon").texture = img_type_icon
		bag_node.get_node("Panel/CharBackground").texture = img_type_bg
		bag_node.get_node("Panel/VBoxContainer2/Lvl").text = "Lvl: "+str(hero.hero_lvl) +"/"+str(hero.hero_maxlvl)
		bag_node.get_node("Panel/VBoxContainer2/Exp").text = "Exp: "+str(hero.hero_exp) + "/" +str(hero.hero_uplvl)
		bag_node.get_node("Panel/VBoxContainer2/HP").text = "HP: "+str(hero.hero_hp)
		bag_node.get_node("Panel/VBoxContainer2/Atk").text = "Atk: "+str(hero.hero_atk)
		bag_node.get_node("Panel/VBoxContainer2/Def").text = "Def: "+ str(hero.hero_def)
		bag_node.get_node("Panel/VBoxContainer2/Rec").text = "Rec: " +str(hero.hero_rec)
		bag_node.get_node("Panel/Story").text = hero.hero_story
		
		bag_node.get_node("Panel").visible = true
		for each in bag_node.get_node("Panel").get_children():
			each.visible = true
#		$Bag/UnitBody.texture = img_body
		
##		print(get_node("./Bag/GridContainer/PanelContainer/Label").text)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
