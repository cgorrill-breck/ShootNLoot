extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var health = 50

func _physics_process(delta: float) -> void:
	# Add the gravity.
	

	move_and_slide()

func apply_damage(damage):
	health -= damage
	
func _on_hurt_box_hurt(hitbox: Area2D, damage: int) -> void:
	apply_damage(damage)
