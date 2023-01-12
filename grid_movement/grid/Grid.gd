extends TileMap

enum CellType { ACTOR, OBSTACLE, OBJECT, KEY_CHARACTER,TRANSITION,BIG_HOUSE}
export(NodePath) var dialogue_ui

func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)


func get_cell_pawn(cell, type = CellType.ACTOR):
	for node in get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return(node)


func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction

	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		-1:
			set_cellv(cell_target, CellType.ACTOR)
			set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size / 2
		CellType.OBJECT, CellType.ACTOR, CellType.KEY_CHARACTER, CellType.TRANSITION:
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			if target_pawn.name == "Player":
				pass
			else:
				print("Cell %s contains %s" % [cell_target, target_pawn.name])
				if target_pawn.name == "Transition":
					target_pawn.go()
				
				if not target_pawn.has_node("DialoguePlayer"):
					return
				get_node(dialogue_ui).show_dialogue(pawn, target_pawn.get_node("DialoguePlayer"))
			
#			if not target_pawn.has_node("DialogicPlayer"):
#				return			
#			target_pawn.get_node("DialogicPlayer").speak()
			
