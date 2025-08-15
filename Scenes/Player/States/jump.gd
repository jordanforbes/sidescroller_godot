extends State

#states that this state can move to
@export 
var idle_state: State
@export 
var walk_state: State 
@export 
var fall_state: State


func enter() -> void: 
	super()
	parent.animations.play("Jump")
	parent.velocity.y = -parent.jump_force
	update_statename("Jump")

func process_physics(delta: float) -> State:
	#parent.update_velocity()
	parent.velocity.y += gravity * delta
	parent.velocity.x = Input.get_axis('Left', 'Right') * parent.move_speed
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall_state
		
	if parent.is_on_floor():
		parent.velocity.y = 0.0
		if Input.is_action_just_pressed('Left') or Input.is_action_just_pressed("Right") and parent.is_on_floor():
			return walk_state
		else:
			print("is on floor?", parent.is_on_floor())
			return idle_state
	return null
