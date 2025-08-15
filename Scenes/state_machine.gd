class_name State_Machine
extends Node2D

@export 
var starting_state: State 

var current_state: State


#initialize state machine by giving each child a reference to the parent Player class 
func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
		print(child.parent)
		
	#initialize to default state 
	change_state(starting_state)
	
#change to a new state by first clearing out the old state
func change_state(new_state: State) -> void:
	if current_state: 
		current_state.exit()
		
	current_state = new_state
	current_state.enter()
	
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
		
func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state: 
		change_state(new_state)
		
func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
