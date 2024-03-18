extends Node3D

@export var speed: float = 0.025
@export var max_distance: int
@onready var sprite = $"../sprite"


var parent: Node3D
var pawn_controller: Node3D
var active_v3i_path: Array
var is_moving: bool = false
var target_position: Vector3

var old_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = $".."
	pawn_controller = parent.get_parent()
	pawn_controller.move_pawn_signal.connect(_on_pawn_controller_move_pawn)
	old_position = parent.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if active_v3i_path.is_empty():
		return
		
	if parent.velocity.z > 0:
		lgg.dbg(['parent velocity.z', parent.velocity.z])
		sprite.play('walk')
		sprite.flip_h = true
	elif parent.velocity.x > 0:
		sprite.play('walk')
		sprite.flip_h = false
	#elif parent.global_position == old_position:
		#sprite.animation = 'idle'
		
	old_position = parent.global_position
	
	if !is_moving:
		target_position = active_v3i_path.front()
		lgg.dbg(['set target position', target_position])
		is_moving = true
		
	parent.global_position = parent.global_position.move_toward(target_position, speed)

	if parent.global_position == target_position:
		active_v3i_path.pop_front()
		
		if !active_v3i_path.is_empty():
			target_position = active_v3i_path.front()
		else:
			lgg.dbg(['pawn done moving'])
			is_moving = false
			
func _on_pawn_controller_move_pawn(id: int, v3i_path: Array):
	if parent.id != id or is_moving:
		return
	lgg.dbg(['vector3 path', v3i_path])
		
	active_v3i_path = v3i_path
