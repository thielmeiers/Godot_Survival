extends Area2D
@export var SPEED: float = 600.0
var direction: Vector2

func _ready():
	set_as_top_level(true)
	
func _process(delta):
	position += direction * SPEED * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.queue_free()
		queue_free()
