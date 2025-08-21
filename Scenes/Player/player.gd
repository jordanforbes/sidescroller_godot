class_name Player
extends CharacterBody2D

@export var state_machine: Node2D
@export var animations: AnimatedSprite2D
@onready var face_left := true

@export_category("Speed Stats")
@export var move_speed: float = 200
@export var jump_force: float = 100
@export_range(0,4) var time_to_reach_max: float
@export_range(0,4) var time_to_reach_zero: float

@export_category("Stats")
@export var HP:= 10

@export_category("Projectile")
@export var projectile_scene: PackedScene
@export var projectile_spawn_offset := Vector2(20,-7) #gun barrrel position

var shot_finished = false

#labels
@export var state_label: Label
var fall_speed : float

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void: 
	state_machine.init(self)
	
func die() -> void:
	print("player has died")
	
#func travel() -> void:
	#velocity.y += fall_speed
	#var horizontal_movement = Input.get_axis('left', 'right') * move_speed
	#velocity.x = horizontal_movement
	#animations.flip_h = horizontal_movement < 0
	#move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
#
func _physics_process(delta: float) -> void:
	fall_speed = gravity * delta
	animations.flip_h = face_left

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
