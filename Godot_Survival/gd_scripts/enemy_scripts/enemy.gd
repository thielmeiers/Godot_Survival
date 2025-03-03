extends CharacterBody2D

@export var target_to_chase: CharacterBody2D = null
const SPEED = 200.0
const SWORD_DISTANCE = 90.0
const SWING_SPEED = 10.0

@export var sword_scene: PackedScene = preload("res://scenes/enemy_scenes/sword.tscn")

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var damage_cooldown_timer := $DamageCooldown

var sword: Node2D
var swing_angle: float = 0.0

func _ready() -> void:
	add_to_group("Enemy")

	if sword_scene:
		sword = sword_scene.instantiate() as Node2D
		add_child(sword)
		sword.position = Vector2(SWORD_DISTANCE, 0)
	else:
		print("Error: Sword scene not found!")

func _process(delta: float) -> void:
	if target_to_chase == null:
		var players = get_tree().get_nodes_in_group("Player")
		if players.size() > 0:
			target_to_chase = players[0]

	if target_to_chase and sword:
		update_sword_position_and_rotation(delta)

func _physics_process(delta: float) -> void:
	if target_to_chase:
		make_path()
		var next_position = nav_agent.get_next_path_position()
		var direction_to_player = (next_position - global_position).normalized()
		velocity = direction_to_player * SPEED
		move_and_collide(velocity * delta)

func make_path():
	if target_to_chase:
		nav_agent.target_position = target_to_chase.global_position

func update_sword_position_and_rotation(delta: float) -> void:
	if sword == null:
		print("Error: Sword is null, cannot update position.")
		return

	var direction_to_player = (target_to_chase.global_position - global_position).normalized()
	if abs(direction_to_player.x) > abs(direction_to_player.y):
		if direction_to_player.x > 0:
			sword.position = Vector2(SWORD_DISTANCE, 0)
			sword.rotation_degrees = 90
		else:
			sword.position = Vector2(-SWORD_DISTANCE, 0)
			sword.rotation_degrees = -90
	else:
		if direction_to_player.y > 0:
			sword.position = Vector2(0, SWORD_DISTANCE)
			sword.rotation_degrees = 180
		else:
			sword.position = Vector2(0, -SWORD_DISTANCE)
			sword.rotation_degrees = 0

	swing_angle += SWING_SPEED * delta
	sword.rotation_degrees += 45 * sin(swing_angle)

func _on_damage_cooldown_timeout():
	damage_cooldown_timer.stop()

func _on_body_entered(body: Node2D) -> void:
	if !damage_cooldown_timer.is_stopped():
		return

	if body.is_in_group("Player") and body.has_method("take_damage"):
		body.take_damage(1)
		damage_cooldown_timer.start()
