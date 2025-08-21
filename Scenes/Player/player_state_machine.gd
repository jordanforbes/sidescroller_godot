class_name Player_State_Machine
extends State_Machine


var player: CharacterBody2D

#---input flags---
var move_left := false 
var move_right := false 
var jump_pressed := false 
var shoot_pressed := false

#initialize state machine 
func init(parent: CharacterBody2D) -> void:
	player = parent
	change_state(starting_state)
	
		
func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		print("left pressed")
		move_left = true 
		print(move_left)
		player.face_left = true
	if event.is_action_released("left"):
		move_left = false
		print(move_left)

	if event.is_action_pressed("right"):
		print("right pressed")
		move_right = true 
		player.face_left = false
		print(move_right)
	if event.is_action_released("right"):
		move_right = false
		print(move_right)
		
	if event.is_action_pressed("jump"):
		if player.is_on_floor():
			jump_pressed = true 
		
	if event.is_action_pressed("shoot"):
		shoot_pressed = true 
		
	
func process_physics(delta: float) -> void:
	print("player process physics")
	match current_state:
		States.IDLE:
			if previous_state == States.FALL:
				player.animations.play("Land")
			player.animations.play("Idle")
			player.velocity.x = 0
			player.velocity.y += player.gravity * delta
			player.move_and_slide()

			if not player.is_on_floor():
				change_state(States.FALL)
			elif move_left or move_right:
				change_state(States.WALK)
			elif jump_pressed:
				jump_pressed = false
				change_state(States.JUMP)
			elif shoot_pressed:
				change_state(States.SHOOT)

		States.WALK:
			print("walk state")
			player.animations.play("Walk")
			var dir := 0
			if move_left:
				dir -= 1
			if move_right:
				dir += 1

			player.velocity.x = dir * player.move_speed
			player.velocity.y += player.gravity * delta
			player.move_and_slide()

			if dir == 0:
				change_state(States.IDLE)
			elif not player.is_on_floor():
				change_state(States.FALL)
			elif jump_pressed:
				jump_pressed = false
				change_state(States.JUMP)
			elif shoot_pressed:
				change_state(States.SHOOT)

		States.JUMP:
			player.animations.play("Jump")
			player.velocity.y = -player.jump_force
			player.move_and_slide()
			# clear the jump input so it doesn't repeat
			jump_pressed = false

			change_state(States.FALL)

		States.FALL:
			player.animations.play("Air")
			var dir := 0
			if move_left:
				dir -= 1
			if move_right:
				dir += 1
			player.velocity.x = dir * player.move_speed
			player.velocity.y += player.gravity * delta
			player.move_and_slide()

			if shoot_pressed:
				change_state(States.SHOOT)
			if player.is_on_floor():
				change_state(States.IDLE)

		States.SHOOT:
			if !player.is_on_floor():
				player.animations.play("Shoot_Air")
			else:
				player.animations.play("Shoot")
			spawn_projectile()
			shoot_pressed = false
			# return to previous state (idle, walk, jump, fall) after shooting
			change_state(previous_state if previous_state else States.IDLE)



func process_frame(delta: float) -> void:
	pass
	

	
func spawn_projectile() -> void:
	if player.projectile_scene:
		var projectile = player.projectile_scene.instantiate()

		var dir = Vector2.RIGHT
		if player.animations.flip_h:
			projectile.animations.flip_h = false
			player.projectile_spawn_offset = Vector2(-20,-7)
			dir = Vector2.LEFT
		else:
			player.projectile_spawn_offset = Vector2(20,-7)
		projectile.global_position = player.global_position + player.projectile_spawn_offset
		# Set projectile direction based on facing
		projectile.direction = dir
		player.get_tree().current_scene.add_child(projectile)
