extends State_Machine

enum STATE { 
	IDLE,
	WALK,
	JUMP,
	FALL,
	SHOOT
}

func _on_shoot_shot_finished() -> void:
	change_state(starting_state)
