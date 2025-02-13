class_name HurtBox
extends Area2D

signal hurt(hitbox: Area2D, damage: int)

func take_damage(hitbox: HitBox, damage: int):
	hurt.emit(hitbox, damage)
	
func _on_area_entered(hitbox: Area2D) -> void:
	if not hitbox is HitBox:
		return
	take_damage(hitbox, hitbox.damage)
