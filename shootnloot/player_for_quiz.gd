extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 60.0
var direction = Vector2.ZERO

func _process(delta: float) -> void:
	if direction == Vector2.ZERO:
		animated_sprite_2d.play("idle")
	elif direction.y < 0:
		animated_sprite_2d.play("walk_up")
	elif direction.y > 0:
		animated_sprite_2d.play("walk_down")
	elif direction.x < 0:
		animated_sprite_2d.play("walk_right")
		animated_sprite_2d.scale.x = -1
	elif direction.x > 0:
		animated_sprite_2d.play("walk_right")
		animated_sprite_2d.scale.x = 1

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down")
	direction = input_vector
	velocity = input_vector * SPEED
	move_and_slide()
