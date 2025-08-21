extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TYPE = "Enemy"

@export var Name := "Ogre"
@export var HP := 10

#labels
@export var name_label: Label
@export var hp_label: Label

@export var animations: AnimatedSprite2D
@export var state_machine: State_Machine

@onready var face_left := true


func _ready() -> void:
	update_hp(HP)
	name_label.text = Name
	state_machine.init(self)
	#print("enemy hello")

#damage functions
func change_hp(dmg: int) -> void:
	HP += dmg

func die() -> void:
	if HP <= 0:
		self.queue_free()
		
func take_damage(dmg: int) -> void:
	change_hp(-dmg)
	die()
	update_hp(HP)
		
#update label's HP
func update_hp(hit_pts: int) -> void:
	hp_label.text = "HP: "+str(hit_pts)
	
func _physics_process(delta: float) -> void:
	pass
