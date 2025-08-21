class_name State_Machine
extends Node2D

enum States{
	IDLE, 
	MOVE,
	WALK,
	JUMP,
	FALL,
	ATTACK,
	SHOOT,
	SEARCH,
	CHASE
	}

@export var starting_state : States

var current_state
var previous_state


#initialize state machine by giving each child a reference to the parent Player class 
func init(parent: CharacterBody2D) -> void:
	pass
	
#change to a new state by first clearing out the old state
func change_state(new_state: States) -> void:
	print("change state function")
	if current_state != null: 
		"current state is not null"
		previous_state = current_state
	print("current state = new state")
	print(States.IDLE)
	current_state = new_state
	
# 🔑 Dispatchers so children can override
func _physics_process(delta: float) -> void:
	process_physics(delta)

func _process(delta: float) -> void:
	process_frame(delta)

func _input(event: InputEvent) -> void:
	process_input(event)

# overridable methods
func process_physics(delta: float) -> void:
	pass

func process_input(event: InputEvent) -> void:
	pass

func process_frame(delta: float) -> void:
	pass
