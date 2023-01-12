extends Control

export(PackedScene) var info_scene
export(PackedScene) var character_scene
export(PackedScene) var sprite_scene
export(PackedScene) var opp_scene

var icon_path = "res://heros/icon_head/"
var body_path = "res://heros/full_body/"

func initialize(combat_combatants):
	
	var i = 0
	var Xpos = 0
	for index in range(0,6):
#		print("index: " + str(index))
#		print("i: " + str(i))
		var char_info = character_scene.instance()
		var sprite_info = sprite_scene.instance()
		
		if i >= Main.allmyheros.heroarray.size():
			char_info.get_node("Panel").visible=true
			char_info.get_node("TouchScreenButton").visible=false
			sprite_info.get_node("Sprite/Pivot/Shadow").texture = null

		else:
			char_info.get_node("Panel").visible=false
			char_info.get_node("TouchScreenButton").visible=true
			
			var health_info = char_info.get_node("HSplitContainer/VBoxContainer/Health")
			var health = sprite_info.get_node("Health")
			health.connect("health_changed", health_info, "set_value")
			health.max_life = Main.allmyheros.heroarray[i].hero_hp
			health.life = Main.allmyheros.heroarray[i].hero_hp

			
			var sm_info = char_info.get_node("HSplitContainer/VBoxContainer/SM")
			health_info.max_value = Main.allmyheros.heroarray[i].hero_hp
			health_info.value = health_info.max_value 
			sm_info.value = 0
			char_info.get_node("HSplitContainer/VBoxContainer/Name").text = Main.allmyheros.heroarray[i].hero_name
	#		info.get_node("HSplitContainer/VBoxContainer/HPLabel").text = "HP: " + str(health_info.value) + "/" + str(Main.allheros.heroarray[i].hero_hp)
	#		health.connect("health_changed", health_info, "set_value")
			
			
			var img_icon = load(icon_path+Main.allmyheros.heroarray[i].hero_code+".png")
			char_info.get_node("HSplitContainer/Icon").texture = img_icon
			var img_body = load(body_path+Main.allmyheros.heroarray[i].hero_code+".png")
			sprite_info.get_node("Sprite/Pivot/Body").texture = img_body
			sprite_info.get_node("Label").text = Main.allmyheros.heroarray[i].hero_name
			
		if(i>=3):
			if(i==3):
				Xpos=0
			sprite_info.position.y = sprite_info.position.x+200
		sprite_info.position.x = sprite_info.position.x+Xpos
		i=i+1
		Xpos = Xpos + 250
		$HeroSprite.add_child(sprite_info)
		$VSplitContainer/Combatants.add_child(char_info)
	i=0
##for opponent
	i = 0
	Xpos = 0
	for code in combat_combatants[1].get_node("Team").team:
		if(code!=""):
#	var code = combat_combatants[1].get_node("Team").hero2_code
			var opp_hero = $"/root/Main".allheros.codeForHero(code)

			var info = info_scene.instance()
			var opp_sprite_info = opp_scene.instance()
			var health_info = info.get_node("VBoxContainer/Health")
			
			var health = opp_sprite_info.get_node("Health")
			health_info.max_value = opp_hero.hero_hp
			health_info.value = health_info.max_value 
			health.max_life = opp_hero.hero_hp
			health.life = health_info.max_value 
			health.connect("health_changed", health_info, "set_value")
			
			info.get_node("VBoxContainer/Name").text = opp_hero.hero_name
			
			var img_body = load(body_path+opp_hero.hero_code+".png")
			opp_sprite_info.get_node("Sprite/Pivot/Body").texture = img_body
			
			opp_sprite_info.get_node("Sprite/Pivot/Body").set_flip_h(true)
			
			opp_sprite_info.get_node("Label").text = opp_hero.hero_name
		#	opp_sprite_info.get_node("Sprite/Pivot/Body").modulate=Color( 100, 100, 100, 100 )
		
			if(i>=3):
				if(i==3):
					Xpos=0
				opp_sprite_info.position.y = opp_sprite_info.position.x+200
			opp_sprite_info.position.x = opp_sprite_info.position.x+Xpos
			i=i+1
			Xpos = Xpos - 250
			$OppSprite.add_child(opp_sprite_info)
			$VSplitContainer.add_child(info)
			$VSplitContainer.move_child(get_node("VSplitContainer/Combatants"),$VSplitContainer.get_child_count()-1)
	
	for each in $VSplitContainer.get_children():
		if each is PanelContainer:
			each.visible=false
	
	$VSplitContainer.get_children()[0].visible=true
	
func update_opp_info(alive):
	for each in $VSplitContainer.get_children():
		if each is PanelContainer:
			each.visible=false
	
	$VSplitContainer.get_children()[alive].visible=true
	
	pass
