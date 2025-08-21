extends State

#@export 
#var idle_state: State
#@export 
#var walk_state: State 
#@export 
#var jump_state: State
#@export 
#var fall_state: State
@export 
var idle_state: State

@export 
var projectile_scene: PackedScene
@export 
var projectile_spawn_offset := Vector2(20,-7) #gun barrrel position

var finished = false

signal shot_finished


# Called when the node enters the scene tree for the first time.
func enter()-> void:
	super()
	finished = false
	play()
	spawn_projectile()
	
func play() -> void: 
	if !parent.is_on_floor():
		parent.animations.play("Shoot_Air")
	else:
		parent.animations.play("Shoot")

	
func spawn_projectile() -> void:
	if projectile_scene:
		var projectile = projectile_scene.instantiate()

		var dir = Vector2.RIGHT
		if parent.animations.flip_h:
			projectile.animations.flip_h = false
			projectile_spawn_offset = Vector2(-20,-7)
			dir = Vector2.LEFT
		else:
			projectile_spawn_offset = Vector2(20,-7)
		projectile.global_position = parent.global_position + projectile_spawn_offset
		# Set projectile direction based on facing
		projectile.direction = dir
		parent.get_tree().current_scene.add_child(projectile)


func _on_animations_animation_finished() -> void:
	print("animation finished")
	finished = true 
	
func process_physics(delta:float) -> State: 
	 # Apply gravity
	parent.velocity.y += gravity * delta
	
	# Keep horizontal velocity if moving
	var movement = 0.0
	if Input.is_action_pressed("Left"):
		movement -= parent.move_speed
	if Input.is_action_pressed("Right"):
		movement += parent.move_speed
	parent.velocity.x = movement
	if movement != 0:
		parent.animations.flip_h = movement < 0
	
	# Move character
	parent.move_and_slide()
	if finished == true: 
		shot_finished.emit()
		finished = false
		return idle_state
	else:
		return null
