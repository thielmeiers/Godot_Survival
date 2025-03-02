extends CharacterBody2D

const SPEED = 300.0

@export var bullet_scene: PackedScene

func _ready() -> void:
	add_to_group("Player")

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	
	aim()
	move()
	shoot()

func shoot():
	if Input.is_action_just_pressed("shoot") and bullet_scene:
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.position = global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()

func aim():
	var mouse_pos = get_global_mouse_position()
	var aim_direction = mouse_pos
	look_at(aim_direction)

func move():
	var direction = Vector2.ZERO
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
		
	velocity = direction * SPEED
	move_and_slide()
