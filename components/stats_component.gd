extends Node

var max_strength: int = 100
var current_strength: int
var max_dexterity: int =100
var current_dexterity: int
var max_intelligence: int = 100
var current_intelligence: int

func _ready():
	current_strength = max_strength
	current_dexterity = max_dexterity
	current_intelligence = max_intelligence
	pass 

func set_current_strength(target_strength: int):
	if (0 <= target_strength) and (target_strength <= max_strength):
		current_strength = target_strength
	elif target_strength < 0:
		lgg.wrn(["Attempted to set <character> strength to less than zero, setting to zero instead."])
		current_strength = 0
	else:
		lgg.wrn(['Attempted to set <character> strength to more than max, setting to max_strength: ', max_strength, ' instead.'])
		current_strength = max_strength

func get_current_strength():
	return current_strength

func mod_current_strength(modifier: int):
	current_strength += modifier

	if current_strength < 0:
		lgg.wrn(["Attempted to set <character> strength to less than zero, setting to zero instead."])
		current_strength = 0
	elif current_strength > max_strength:
		lgg.wrn(['Attempted to set <character> strength to more than max, setting to max_strength: ', max_strength, ' instead.'])
		current_strength = max_strength

func set_max_strength(new_max_strength):
	max_strength = new_max_strength
	if current_strength > max_strength:
		current_strength = max_strength

func get_max_strength():
	return max_strength

func mod_max_strength(modifier: int):
	max_strength += modifier
	if current_strength > max_strength:
		current_strength = max_strength


func set_current_dexterity(target_dexterity: int):
	if (0<= target_dexterity) and (target_dexterity <= max_dexterity):
		current_dexterity = target_dexterity
	elif target_dexterity < 0:
			lgg.wrn(["Attempted to set <character> dexterity to less than zero, setting to zero instead"])
			current_dexterity = 0
	else:
		lgg.wrn(['Attempted to set <character> dexterity to more than max, setting to max_dexterity'])

func get_current_dexterity():
	return current_dexterity

func mod_current_dexterity(modifier: int):
	current_dexterity += modifier
	

	if current_dexterity < 0:
		lgg.wrn(["Attempted to set <character> dexterity to less than zero, setting to zero instead."])
		current_dexterity = 0
	elif current_dexterity > max_dexterity:
		lgg.wrn(['Attempted to set <character> dexterity to more than max, setting to max_dexterity: ', max_dexterity, ' instead.'])
		current_dexterity = max_dexterity

func set_max_dexterity(new_max_dexterity):
	max_dexterity = new_max_dexterity
	if current_dexterity > max_dexterity:
		current_dexterity = max_dexterity

func get_max_dexterity():
	return max_dexterity

func mod_max_dexterity(modifier: int):
	max_dexterity += modifier
	if current_dexterity > max_dexterity:
		current_dexterity = max_dexterity


func set_current_intelligence(target_intelligence: int):
	if (0<= target_intelligence) and (target_intelligence <= max_intelligence):
		current_intelligence = target_intelligence
	elif target_intelligence < 0:
			lgg.wrn(["Attempted to set <character> intelligence to less than zero, setting to zero instead"])
			current_intelligence = 0
	else:
		lgg.wrn(['Attempted to set <character> intelligence to more than max, setting to max_intelligence'])

func get_current_intelligence():
	return current_intelligence

func mod_current_intelligence(modifier: int):
	current_intelligence += modifier

	if current_intelligence < 0:
		lgg.wrn(["Attempted to set <character> intelligence to less than zero, setting to zero instead."])
		current_intelligence = 0
	elif current_intelligence > max_intelligence:
		lgg.wrn(['Attempted to set <character> intelligence to more than max, setting to max_intelligence: ', max_intelligence, ' instead.'])
		current_intelligence = max_intelligence

func set_max_intelligence(new_max_intelligence):
	max_intelligence = new_max_intelligence
	if current_intelligence > max_intelligence:
		current_intelligence = max_intelligence

func get_max_intelligence():
	return max_intelligence

func mod_max_intelligence(modifier: int):
	max_intelligence += modifier
	if current_intelligence > max_intelligence:
		current_intelligence = max_intelligence
