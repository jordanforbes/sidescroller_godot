extends State

@export 
var idle_state: State
@export 
var walk_state: State 
@export 
var jump_state: State
@export 
var fall_state: State

@export 
var projectile_scene: PackedScene
@export 
var projectile_spawn_offset := Vector2(20,-7) #gun barrrel position

var finished = false


# Called when the node enters the scene tree for the first time.
func enter()-> void:
	#super()
	finished = false
	play()
	spawn_projectile()
	#update_statename("Shoot")
	
func play() -> void: 
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
	if finished == true: 
		finished = false
		if Input.is_action_just_pressed('Jump') and parent.is_on_floor():
			print("space bar pressed")
			return jump_state
		elif Input.is_action_pressed('Left') or Input.is_action_just_pressed("Right") and parent.is_on_floor():
			print("walk state keys pressed")
			return walk_state
		else:
			return idle_state
	else:
		return null
