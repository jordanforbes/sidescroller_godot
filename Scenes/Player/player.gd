class_name Player
extends CharacterBody2D

@export
var state_machine: State_Machine
#@onready 
#var attack_machine = $Attack_Machine 
@export 
var attack_machine: State_Machine

@onready 
var animations = $Animations
@onready 
var face_right := true


@export
var move_speed: float = 200
@export
var jump_force: float = 100

#labels
@export 
var state_label: Label
#@export
#var velocity_label: Label
#
##velocity label update
#func update_velocity() -> void:
	#velocity_label.text = "Velocity:" +str(self.velocity)

func _ready() -> void: 
	state_machine.init(self)
	#attack_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
