extends GridMap

var astar: AStar2D = AStar2D.new()
var tiles: Dictionary
const TILE_HIGHLIGHT = preload("res://prefabs/tile_highlight.tscn")
@onready var terrain_cam = %terrain_cam
@onready var tile_selector = $tile_selector
@onready var focus = $"../focus"

var intersect_result
var focus_position = null


# Called when the node enters the scene tree for the first time.
func _ready():
	read_cells()
	create_points()
	create_paths()
	
func _unhandled_input(event):
	if event.is_action_pressed("accept"):
		on_accept_action(event)
	elif event.is_action_pressed("cancel"):
		on_cancel_action(event)

func read_cells():
	lgg.inf(['tactics_map.read_cells()'])
	var cells = get_used_cells()
	cells.sort_custom(sort_v3s)
	create_tiles(cells)

func point_id_to_global(point_id: int):
	return tiles[str(point_id)].top

func highlight_path(start_id: int, end_id: int):
	var id_path = astar.get_id_path(start_id, end_id)
	var instances = []
	for id in id_path:
		var tile_data = tiles[str(id)]
		instances.append(TILE_HIGHLIGHT.instantiate())
		var global = tile_data.top
		lgg.dbg(['highlted tile', tile_data.top])
		add_child(instances[-1])
		instances[-1].global_position = global
		
func display_tiles():
	for key in tiles:
		var data = tiles[key]
		lgg.inf([key, data.coord, data.height, get_tile_neighbor_ids(data)])

func create_tiles(v3i_coords: Array[Vector3i]):
	lgg.inf(['tactics_map.create_tiles()'])
	var temp_coords = []
	var current_point_id: int = 0
	for v3i_coord in v3i_coords:
		var coord = Vector2i(v3i_coord.x, v3i_coord.z)
		var height = int(v3i_coord.y)
		if temp_coords.has(coord):
			#print("Skipped coord ", coord, " at height ", height)
			continue
		temp_coords.append(coord)
		var mesh_id = get_cell_item(v3i_coord)
		var name_info = mesh_library.get_item_name(mesh_id).split('_')
		
		#print("Name: ", name_info[0], "\tMeshID: ", mesh_id, "\tType: ", name_info[1], "\tCoord: ", coord, "\tHeight: ", height)
		
		var new_tile = {
			"name": name_info[0], #string, block type
			"type": name_info[1], #, string, block/step
			"coord": coord, #v2 coord
			"height": height, #int
			"mesh_id": mesh_id, #int, id from mesh_library
			"point_id": current_point_id
		}
		var top
		if new_tile.type == "block":
			top = Vector3(v3i_coord.x, v3i_coord.y + 1, v3i_coord.z)
		elif new_tile.type == "step":
			top = Vector3(v3i_coord.x, v3i_coord.y + .5, v3i_coord.z)
			
		
		new_tile['top'] = top
		
		tiles[str(current_point_id)] = new_tile
		current_point_id += 1
		
func create_points():
	lgg.inf(['tactics_map.create_points()'])
	for tile_id in tiles:
		var tile_data = tiles[tile_id]
		astar.add_point(tile_data.point_id, tile_data.coord)
		
func create_paths():
	lgg.inf(['tactics_map.create_paths()'])
	for tile_id in tiles:
		var tile_data = tiles[tile_id]
		var neighbor
		for point_id in get_tile_neighbor_ids(tile_data):
			neighbor = tiles[str(point_id)]
			if astar.are_points_connected(tile_data.point_id, point_id):
				continue
			elif tile_data.height == neighbor.height:
				astar.connect_points(tile_data.point_id, point_id)
			elif tile_data.height - neighbor.height == 1 and neighbor.type == 'step':
				astar.connect_points(tile_data.point_id, point_id)
			pass
		
func get_tile_neighbor_ids(center_tile_data):
	var neighbor_coords = Array()
	neighbor_coords.append(center_tile_data.coord + Vector2i(0, 1)) #north
	neighbor_coords.append(center_tile_data.coord + Vector2i(1, 0)) #east
	neighbor_coords.append(center_tile_data.coord - Vector2i(0, 1)) #south
	neighbor_coords.append(center_tile_data.coord - Vector2i(1, 0)) #west
	neighbor_coords.sort_custom(sort_v2s)
	
	var neighbor_point_ids = Array()
	for coord in neighbor_coords:
		for tile_data in tiles.values():
			if tile_data.coord == coord:
				lgg.dbg(['Neighbor point found!', coord, '== tile_data.coord:', tile_data.coord])
				neighbor_point_ids.append(tile_data.point_id)
	
	return neighbor_point_ids
	
func get_tile_data_from_v2i(v2i: Vector2i):
	for tile in tiles.values():
		if tile.coord == v2i:
			return tile
	return null

func on_accept_action(event):
	if !intersect_result.has('position'):
		lgg.wrn(['Result Dictionary has no position'])
		lgg.wrn([intersect_result])
		tile_selector.hide()
		return
	
	var clicked_tile_coord = Vector2i(snapped(intersect_result.position.x, 1), snapped(intersect_result.position.z, 1))
	var height = intersect_result.position.y
	lgg.dbg(['Clicked Coord:', clicked_tile_coord, 'Height: ', height])
	
	var valid_tile = get_tile_data_from_v2i(clicked_tile_coord)

	if valid_tile != null:
		lgg.dbg([valid_tile.type])
		tile_selector.move_selector(valid_tile.top)
		focus_position = valid_tile.top
		
func on_cancel_action(event):
	tile_selector.hide()
	
func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var origin = terrain_cam.project_ray_origin(mousepos)
	var end = origin + terrain_cam.project_ray_normal(mousepos) * 100
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	intersect_result = space_state.intersect_ray(query)
	
	if focus_position != null:
		focus.global_position = focus.global_position.move_toward(focus_position, 0.2)

func sort_v3s(a: Vector3i, b: Vector3i):
	if a.x < b.x: # lowest x first
		return true
	elif a.x > b.x:
		return false
	else:
		if a.z < b.z: #lowest z next
			return true
		elif a.z > b.z:
			return false
		else:
			if a.y > b.y: #highest y finally
				return true
			elif a.y < b.y:
				return false
				
func sort_v2s(a: Vector2i, b: Vector2i):
	if a.x < b.x:
		return true
	elif a.x > b.x:
		return false
	else:
		if a.y < b.y:
			return true
		elif a.y > b.y:
			return false
