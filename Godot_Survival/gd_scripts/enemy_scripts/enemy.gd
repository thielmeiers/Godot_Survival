extends CharacterBody2D

@export var target_to_chase: CharacterBody2D = null
const SPEED = 200.0

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready() -> void:
	add_to_group("Enemy")

func _process(delta: float) -> void:
	if target_to_chase == null:
		var players = get_tree().get_nodes_in_group("Player")
		if players.size() > 0:
			target_to_chase = players[0]

func _physics_process(delta: float) -> void:
	if target_to_chase:
		make_path()
		var next_position = nav_agent.get_next_path_position()
		var direction_to_player = (next_position - global_position).normalized()
		velocity = direction_to_player * SPEED
		move_and_collide(velocity * delta)  # Instead of move_and_slide()

func make_path():
	if target_to_chase:
		nav_agent.target_position = target_to_chase.global_position

func _on_timer_timeout():
	if target_to_chase:
		make_path()
