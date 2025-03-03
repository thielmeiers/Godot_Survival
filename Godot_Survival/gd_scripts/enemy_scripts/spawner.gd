extends Node2D
@export var enemy_scenes : Array = [
	preload("res://scenes/enemy_scenes/enemy.tscn")
	]

func spawn_enemy():
	if enemy_scenes.size() > 0:
		var random_enemy = enemy_scenes[randi() % enemy_scenes.size()]
		var enemy = random_enemy.instantiate()
		enemy.global_position = global_position
		get_parent().add_child(enemy)
	else:
		print("No enemy scenes")

func _on_timer_timeout() -> void:
	spawn_enemy()
