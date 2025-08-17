extends Area2D

@export 
var speed := 500.0
@export 
var direction := Vector2.RIGHT
@export 
var animations := AnimatedSprite2D
@export 
var dmg :=2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	

func _on_body_entered(body: Node2D) -> void:
	print("body entered: ",body.name)
	if body.has_method("take_damage"):
		body.take_damage(dmg)
	queue_free()
