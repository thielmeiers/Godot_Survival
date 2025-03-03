extends Node

@export var max_health: int = 4
@export var current_health: int = 4
@onready var health_bar = $HealthIcons/TextureRect

var full_heart_texture = preload("res://assets/health_assets/4_4_heart.png")
var three_heart_texture = preload("res://assets/health_assets/3_4_heart.png")
var two_heart_texture = preload("res://assets/health_assets/2_4_heart.png")
var one_heart_texture = preload("res://assets/health_assets/1_4_heart.png")
var empty_heart_texture = preload("res://assets/health_assets/empty_heart.png")

func take_damage(damage: int) -> void:
	current_health -= damage
	if current_health < 0:
		current_health = 0
	update_health_bar()

func heal(amount: int) -> void:
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	update_health_bar()

func update_health_bar() -> void:
	if current_health == max_health:
		health_bar.texture = full_heart_texture
	elif current_health == 3:
		health_bar.texture = three_heart_texture
	elif current_health == 2:
		health_bar.texture = two_heart_texture
	elif current_health == 1:
		health_bar.texture = one_heart_texture
	else:
		health_bar.texture = empty_heart_texture
