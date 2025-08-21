extends State

#states that this state can move to
@export 
var idle_state: State
@export 
var walk_state: State
@export 
var shoot_state: State

func enter()-> void:
	update_statename("Fall")
	parent.animations.play("Air")

func process_physics(delta: float) -> State:

	
	var movement = Input.get_axis("Left", "Right") * parent.move_speed
	
	if Input.is_action_just_pressed("Shoot"):
		print("shoot pressed")
		return shoot_state
	
	parent.travel()

	
	if parent.is_on_floor():
		if movement != 0:
			return walk_state
		return idle_state
	return null
