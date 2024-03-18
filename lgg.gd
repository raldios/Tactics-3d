extends Node3D

const LOG_VERBOSE_LOGGING = true
const LOG_DEBUGGING = true

var red = '[color=DC143C]'
var green = '[color=7FFF00]'
var yellow = '[color=FFD700]'
var orange = '[color=FF4500]'
var cyan = '[color=008B8B]'
var paleturquoise  = '[color=AFEEEE]'

func dbg(strings: Array):
	if LOG_DEBUGGING:
		strings = [yellow, 'DEBUG  --- '] + strings + ['[/color]']
		log_rich(strings)

func inf(strings: Array):
	if LOG_VERBOSE_LOGGING:
		strings = [paleturquoise, 'INFO   --- '] + strings + ['[/color]']
		log_rich(strings)
		
func wrn(strings: Array):
	if LOG_VERBOSE_LOGGING:
		strings = [orange, 'WARN   --- '] + strings + ['[/color]']
		log_rich(strings)
		
func err(strings: Array):
	if LOG_VERBOSE_LOGGING:
		strings = [red, 'ERROR  --- '] + strings + ['[/color]']
		log_rich(strings)
	
func log_rich(strings: Array):
	var time = cyan + Time.get_time_string_from_system() + '[/color]'
	
	strings = [time] + strings
	
	print_rich(" ".join(strings))

