extends Node3D

@onready var tactics_map = $"../tactics_map"

var pawn_index: int = 0
var pawns: Array

signal move_pawn_signal(pawn_id, global_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		pawns.append(child)
		child.id = pawn_index
		pawn_index += 1

func move_pawn(pawn_id: int, start_id: int, end_id: int):
	var id_path = tactics_map.astar.get_id_path(start_id, end_id).slice(1)
	var global_path = []
	for id in id_path:
		global_path.append(tactics_map.point_id_to_global(id))
		
	move_pawn_signal.emit(pawn_id, global_path)
	
func get_pawn_from_id(pawn_id: int):
	return pawns[pawn_id]
	
func get_pawn_from_v3(v3i_coord: Vector3i):
	for pawn in pawns:
		if pawn.coord == v3i_coord:
			return pawn
