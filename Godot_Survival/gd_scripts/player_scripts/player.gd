extends CharacterBody2D

const SPEED = 300.0
@onready var gun = $gun
@onready var player_health = $PlayerHealth

func _ready() -> void:
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	rotate_player_to_mouse()
	move(delta)
	shoot()
	update_health_bar()

func shoot():
	if Input.is_action_just_pressed("shoot"):
		gun.shoot(global_position, rotation)

func rotate_player_to_mouse():
	var mouse_pos = get_global_mouse_position()
	rotation = (mouse_pos - global_position).angle()

func move(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	velocity = direction.normalized() * SPEED
	move_and_collide(velocity * delta)

func take_damage(damage: int) -> void:
	player_health.take_damage(damage)

func update_health_bar():
	var health_icons = player_health.get_node("HealthIcons")
