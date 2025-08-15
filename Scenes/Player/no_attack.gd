extends State

@export 
var shoot_state: State

func enter()->void:
	print("no attack")
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("Shoot"):
		print("shoot pressed")
		return shoot_state
	return null
	
