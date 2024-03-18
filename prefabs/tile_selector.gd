extends Node3D
@onready var sprite = $sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func move_selector(pos: Vector3):
	global_position = pos
	show()
