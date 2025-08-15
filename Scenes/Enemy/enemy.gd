extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TYPE = "Enemy"

@export 
var Name := "Ogre"
@export 
var HP := 10

func _ready() -> void:
	update_hp(HP)
	$NameLabel.text = Name

func change_hp(dmg: int) -> void:
	HP -= dmg
	if HP > 0:
		update_hp(HP)
	else:
		self.queue_free()
		
func update_hp(hit_pts: int) -> void:
	$HPLabel.text = "HP: "+str(hit_pts)
	
func _physics_process(delta: float) -> void:
	pass
