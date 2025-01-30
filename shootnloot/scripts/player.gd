extends CharacterBody2D

const SPEED = 50.0

@export var health = 50
@export var defense = 3

func _physics_process(delta: float) -> void:	
	if health <= 0:
		die()
		
	handle_movement()
	move_and_slide()
	
	
func handle_movement():
	var h_direction := Input.get_axis("left", "right")
	var v_direction := Input.get_axis("up", "down")
	
	velocity.x = h_direction * SPEED
	velocity.y = v_direction * SPEED

func die():
	queue_free()
	
func apply_damage(damage):
	health -= damage

func _on_hurt_box_hurt(hitbox: Area2D, damage: int) -> void:
	apply_damage(damage)
	print("player was hit by " + hitbox.get_parent().name)
