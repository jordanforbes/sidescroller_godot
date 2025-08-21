class_name Enemy_State_Machine
extends State_Machine


var enemy: CharacterBody2D

#how to get random numbers
	#var rng = RandomNumberGenerator.new()

#---input flags---
var move_left := false 
var move_right := false 
var jump_triggered := false 
var attack_triggered := false

func init(parent: CharacterBody2D) -> void:
	enemy = parent
	change_state(starting_state)
	print("enemy state machine")
	
func process_physics(delta: float) -> void:
	print('process physics')
	print(current_state, States.IDLE)
	match current_state: 
		States.IDLE:
			print("idle state activated")
			enemy.animations.play("Idle")
			var timer = Timer.new()
			await get_tree().create_timer(0.2).timeout
			change_state(States.ATTACK)
		States.ATTACK:
			enemy.animations.play("Attack")
			await get_tree().create_timer(0.7).timeout
			change_state(States.ATTACK)
