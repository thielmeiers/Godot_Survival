extends Area2D

@export var SPEED: float = 600.0
var direction: Vector2

func _ready():
	set_as_top_level(true)  # Allows the bullet to move independently

func _process(delta):
	position += direction * SPEED * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()  # Destroys the bullet when it leaves the screen
