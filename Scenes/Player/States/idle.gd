extends State

#states that this state can move to
@export 
var walk_state: State
@export 
var jump_state: State 
@export 
var fall_state: State
@export
var shoot_state: State

func enter() -> void:
	print("idle state entered")
	super()
	parent.velocity.x = 0 
	parent.animations.play("Idle")
	update_statename("Idle")
	

func process_input(event: InputEvent) -> State:
	#parent.update_velocity()

	if Input.is_action_just_pressed('Jump') and parent.is_on_floor():
		print("space bar pressed")
		return jump_state
	if Input.is_action_pressed('Left') or Input.is_action_pressed("Right") and parent.is_on_floor():
		print("walk state keys pressed")
		return walk_state
	if Input.is_action_just_pressed("Shoot"):
		print("shoot pressed")
		return shoot_state
	
	return null
	

	

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta 
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
