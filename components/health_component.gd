extends Node3D

var max_health: int = 100
var current_health: int



# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	pass # Replace with function body.

func set_current_health(target_health: int):
	if (0 <= target_health) and (target_health <= max_health):
		current_health = target_health
	elif target_health < 0:
		lgg.wrn(["Attempted to set <character> health to less than zero, setting to zero instead."])
		current_health = 0
	else:
		lgg.wrn(['Attempted to set <character> health to more than max, setting to max_health: ', max_health, ' instead.'])
		current_health = max_health

func get_current_health():
	return current_health
	
func mod_current_health(modifier: int):
	current_health += modifier

	if current_health < 0:
		lgg.wrn(["Attempted to set <character> health to less than zero, setting to zero instead."])
		current_health = 0
	elif current_health > max_health:
		lgg.wrn(['Attempted to set <character> health to more than max, setting to max_health: ', max_health, ' instead.'])
		current_health = max_health
		
func set_max_health(new_max_health):
	max_health = new_max_health
	if current_health > max_health:
		current_health = max_health
	

func get_max_health():
	return max_health
	

func mod_max_health(modifier: int):
	max_health += modifier
	if current_health > max_health:
		current_health = max_health
	
