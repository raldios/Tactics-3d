extends Node3D

var max_health: int = 100
var current_health: int
var max_stamina: int = 100 
var current_stamina: int
var max_mana: int = 100 
var current_mana: int = 100


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


func set_current_stamina(target_stamina: int):
	if (0 <= target_stamina) and (target_stamina <= max_stamina):
		current_stamina = target_stamina
	elif target_stamina < 0:
		lgg.wrn(["Attempted to set <character> stamina to less than zero, setting to zero instead."])
		current_stamina = 0
	else:
		lgg.wrn(['Attempted to set <character> stamina to more than max, setting to max_stamina: ', max_stamina, ' instead.'])
		current_stamina = max_stamina

func get_current_stamina():
	return current_stamina

func mod_current_stamina(modifier: int):
	current_stamina += modifier

	if current_stamina < 0:
		lgg.wrn(["Attempted to set <character> stamina to less than zero, setting to zero instead."])
		current_stamina = 0
	elif current_stamina > max_stamina:
		lgg.wrn(['Attempted to set <character> stamina to more than max, setting to max_stamina: ', max_stamina, ' instead.'])
		current_stamina = max_stamina

func set_max_stamina(new_max_stamina):
	max_stamina = new_max_stamina
	if current_stamina > max_stamina:
		current_stamina = max_stamina

func get_max_stamina():
	return max_stamina

func mod_max_stamina(modifier: int):
	max_stamina += modifier
	if current_stamina > max_stamina:
		current_stamina = max_stamina


func set_current_mana(target_mana: int):
	if (0 <= target_mana) and (target_mana <= max_mana):
		current_mana = target_mana
	elif target_mana < 0:
		lgg.wrn(["Attempted to set <character> mana to less than zero, setting to zero instead."])
		current_mana = 0
	else:
		lgg.wrn(['Attempted to set <character> mana to more than max, setting to max_mana: ', max_mana, ' instead.'])
		current_mana = max_mana

func get_current_mana():
	return current_mana

func mod_current_mana(modifier: int):
	current_mana += modifier

	if current_mana < 0:
		lgg.wrn(["Attempted to set <character> mana to less than zero, setting to zero instead."])
		current_mana = 0
	elif current_mana > max_mana:
		lgg.wrn(['Attempted to set <character> mana to more than max, setting to max_mana: ', max_mana, ' instead.'])
		current_mana = max_mana

func set_max_mana(new_max_mana):
	max_mana = new_max_mana
	if current_mana > max_mana:
		current_mana = max_mana

func get_max_mana():
	return max_mana

func mod_max_mana(modifier: int):
	max_mana += modifier
	if current_mana > max_mana:
		current_mana = max_mana
