extends State

#states that this state can move to
@export 
var idle_state: State
@export 
var jump_state: State 
@export 
var fall_state: State
@export 
var shoot_state: State

func enter() -> void:
	print('walk state entered')
	parent.animations.play("Walk")
	update_statename("Walk")
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	#parent.update_velocity()

	
	var movement = Input.get_axis('Left', 'Right') * parent.move_speed
	
	if movement == 0:
		return idle_state
	
	parent.travel()
	
	if !parent.is_on_floor():
		return fall_state
		
	if Input.is_action_just_pressed("Shoot"):
		print("shoot pressed")
		return shoot_state
	return null
