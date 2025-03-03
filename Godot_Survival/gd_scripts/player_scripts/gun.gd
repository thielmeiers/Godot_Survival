extends Node2D

@export var bullet_scene: PackedScene = preload("res://scenes/player_scenes/bullet.tscn")
@export var shoot_distance: float = 40.0

func _ready() -> void:
	pass

func shoot(player_position: Vector2, player_rotation: float):
	if bullet_scene:
		var bullet = bullet_scene.instantiate() as Area2D
		if bullet:
			var spawn_position = player_position + Vector2(shoot_distance, 0).rotated(player_rotation)
			bullet.position = spawn_position
			var direction = (get_global_mouse_position() - spawn_position).normalized()
			bullet.direction = direction
			bullet.rotation = direction.angle()
			get_parent().add_child(bullet)
		else:
			print("Failed to instantiate the bullet.")
	else:
		print("bullet_scene is null!")
