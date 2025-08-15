extends RayCast2D


# Called when the node enters the scene tree for the first time.
var direction := 'right'

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if self.is_colliding():
		#if self.get_collider().name == "Enemy":
			##print(self.get_collider().Name)
			##print(self.get_collider().HP)
			##print("see enemy")
			#if Input.is_action_just_pressed("Shoot"):
				#self.get_collider().change_hp(1)
	if int(Input.get_axis('Left','Right'))<0:
		direction = 'left'
		self.target_position.x = -1000.0
	if int(Input.get_axis('Left', 'Right'))>0:
		direction = 'right'
		self.target_position.x = 1000.0
	#print(self.target_position)
	#print(direction)
	
	

#func change_direction() -> void:
	#direction *= Input.get_axis('Left', 'Right')
