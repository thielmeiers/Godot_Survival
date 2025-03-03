extends Node2D

@export var damage: int = 1

var enemy: Node2D
var cooldown_timer: Timer

func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	enemy = get_parent()
	if enemy:
		cooldown_timer = enemy.get_node("DamageCooldown")
		if cooldown_timer == null:
			print("Error: DamageCooldown timer not found on enemy!")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and cooldown_timer and !cooldown_timer.is_stopped():  
		return

	if body.is_in_group("Player") and body.has_method("take_damage"):
		body.take_damage(damage)
		print("Player hit! Damage dealt:", damage)
		cooldown_timer.start()
