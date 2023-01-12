extends CanvasLayer

export(PackedScene)var unit_scene
var icon_path = "res://heros/icon_head/"
var body_path = "res://heros/full_body/"
var show_hero = false

var i = 0
var control_visible

func _ready():
	$Bag/Whitebackground.visible=false
	$Bag/Whitebackground2.visible=false
	$Bag/Label.visible=false
	$Bag/Panel.visible=false

func _hide_controls():
	control_visible = false
	$up.visible = false
	$down.visible = false
	$left.visible = false
	$right.visible = false
	
	$X.visible = false
	$A.visible = false
	$Y.visible = false
	$B.visible = false

func _show_controls():
	control_visible = true
	$up.visible = true
	$down.visible = true
	$left.visible = true
	$right.visible = true
	
	$X.visible = true
	$A.visible = true
	$Y.visible = true
	$B.visible = true

func _input(event):
	if event.is_action_pressed("ui_bag"):
		#open bag page
		$Bag.visible = !$Bag.visible
		$Bag/HeadingLabel.text = "Map"
		$Bag/MapRect.visible=true
		$Bag/Whitebackground.visible = false
		$Bag/Label.visible = false
		$Bag/CameraRect.visible=false
		
		$up.visible = !$up.visible
		$down.visible = !$down.visible
		$left.visible = !$left.visible
		$right.visible = !$right.visible
		
		$X.visible = !$X.visible
		$A.visible = !$A.visible
		$Y.visible = !$Y.visible
		
		#update money, year and location
		$Bag/VBoxContainer/MoneyLabel.text = "Money: $" + str(Main.money)
		$Bag/VBoxContainer/YearLabel.text = "Year: "+str(Main.year)
		$Bag/VBoxContainer/LocationLabel.text = "Location: "+str(Main.location)

	elif event.is_action_pressed("bag_quest"):
		$Bag/HeadingLabel.text = "Quests"
		$Bag/MapRect.visible = false
		$Bag/Whitebackground.visible = true
		$Bag/Label.visible = true
		$Bag/Label.text = Main.allquests._showActiveQuest()
		$Bag/CameraRect.visible=false
		$Bag/GridContainer.visible=false
		$Bag/Panel.visible=false
		
	elif event.is_action_pressed("bag_item"):
		$Bag/HeadingLabel.text = "Items"
		$Bag/MapRect.visible = false
		$Bag/Whitebackground.visible = true
		$Bag/Label.visible = true
		$Bag/Label.text = Main.allitems._showAll()
#		$Bag/Label.text = "1 x Ice Kachang"
		$Bag/CameraRect.visible=false
		$Bag/GridContainer.visible=false
		$Bag/Panel.visible=false

	elif event.is_action_pressed("bag_hero"):
		
		var j = 0
		if $Bag/GridContainer.get_child_count() == 0:
			for index in range(0,6):
				var scene = preload("res://Cyrus/Unit_new.tscn")
				var unit = scene.instance()
				$Bag/GridContainer.add_child(unit)
				if j>=Main.allmyheros.heroarray.size():
					unit.get_node("TouchScreenButton").visible=false
					unit.get_node("Panel").visible=true
				else:
					var img_icon = load(icon_path+Main.allmyheros.heroarray[j].hero_code+".png")
					unit.get_node("Icon").texture = img_icon
					unit.get_node("Label").text = Main.allmyheros.heroarray[j].hero_code
					j=j+1
		$Bag/GridContainer.visible=true
#		$Bag/Panel.visible=true
		$Bag/HeadingLabel.text = "Heroes"
		$Bag/MapRect.visible = false
		$Bag/Whitebackground.visible = true
		$Bag/CameraRect.visible=false
		$Bag/Label.visible=false

	elif event.is_action_pressed("bag_map"):
		$Bag/HeadingLabel.text = "Map"
		$Bag/MapRect.visible = true
		$Bag/Whitebackground.visible = false
		$Bag/Label.visible = false
		$Bag/CameraRect.visible=false
		$Bag/GridContainer.visible=false
		$Bag/Panel.visible=false
		
#	elif event.is_action_pressed("bag_print"):
#		$Bag/Whitebackground2.visible=true
#		$Bag/UnitBody.visible=true
#		var img_body = load(body_path+"001"+".png")
#		$Bag/UnitBody.texture = img_body
##		print(get_node("./Bag/GridContainer/PanelContainer/Label").text)
		
	elif event.is_action_pressed("bag_camera"):
#		var file_array = dir_contents("res://screenshot folder/")
#		Main.allphotos = file_array
		if Main.allphotos.size()==0 :
			$Bag/HeadingLabel.text = "No Picture is taken yet"
			$Bag/Label.visible = false
		else:
			var texture = ImageTexture.new()
			texture.create_from_image(Main.allphotos[i])
			
			$Bag/CameraRect.visible=true
			$Bag/CameraRect.texture = texture

			$Bag/HeadingLabel.text = "Picture " + str(i+1) + "/" + str(Main.allphotos.size()) 
			$Bag/MapRect.visible = false
			$Bag/Whitebackground.visible = false
			$Bag/Label.visible = false
					
			if i == Main.allphotos.size()-1:
				i=0
			else:
				i=i+1
		$Bag/GridContainer.visible=false
		$Bag/Panel.visible=false		
#restart index i when i > array.size
	
func dir_contents(path):
	var dir = Directory.new()
	var file_array = []
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if not ".import" in file_name:  
					file_array.append(file_name)
			file_name = dir.get_next()
	
	else:
		print("An error occurred when trying to access the path.")
	
	return file_array
