extends GridMap

var astar: AStar2D


# Called when the node enters the scene tree for the first time.
func _ready():
	create_nodes()

func create_nodes():
	var cells = get_used_cells()
	cells.sort_custom(sort_v3s)
	remove_duplicates(cells)
	
	pass

func remove_duplicates(cells: Array[Vector3i]):
	var new_cells: Array = Array()
	var temp_coords: Array[Vector2i]
	for cell in cells:
		var coord = Vector2i(cell.x, cell.z)
		var height = int(cell.y)
		var cell_item_id = get_cell_item(cell)
		var item_name = mesh_library.get_item_name(cell_item_id)
		
		print(cell_item_id, item_name)
		
		


func sort_v3s(a: Vector3i, b: Vector3i):
	if a.y > b.y: # highest y first
		return true
	elif a.y < b.y:
		return false
	else:
		if a.z < b.z: #lowest z next
			return true
		elif a.z > b.z:
			return false
		else:
			if a.x < b.x: #lowest x next
				return true
			elif a.x > b.x:
				return false
