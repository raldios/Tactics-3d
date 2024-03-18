extends CharacterBody3D

var id: int
var move_component
var coord: Vector3i

# Called when the node enters the scene tree for the first time.
func _ready():
	move_component = get_node_or_null("move_component")
	
func update_coord(v3i: Vector3i):
	coord = v3i
