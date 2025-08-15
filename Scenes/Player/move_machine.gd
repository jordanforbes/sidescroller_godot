extends State_Machine


func _on_shoot_shot_finished() -> void:
	change_state(starting_state)
