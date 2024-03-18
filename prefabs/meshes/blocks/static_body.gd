extends StaticBody3D

@onready var highlight = $"../highlight"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _mouse_enter():
	highlight.show()
	
func _mouse_exit():
	highlight.hide()
