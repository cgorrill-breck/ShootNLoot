class_name Player_Stats
extends Node
const BASE_SPEED := 100.0
# Exported properties
@export var _health: int = 10
@export var _defense: int = 10
@export var _attack_power: int = 10
@export var _move_speed: float = BASE_SPEED
@export var _level: int = 1
@export var _experience: int = 0
@export var _acceleration : float = _move_speed / 4

# Getters
func get_health() -> int:
	return _health

func get_defense() -> int:
	return _defense

func get_attack_power() -> int:
	return _attack_power

func get_move_speed() -> float:
	return _move_speed

func get_acceleration() -> float:
	return _acceleration

func get_level() -> int:
	return _level

func get_experience() -> int:
	return _experience

# Setters
func set_health(value: int) -> void:
	_health = max(value, 0) # Ensure health doesn't go negative

func set_defense(value: int) -> void:
	_defense = max(value, 0)

func set_attack_power(value: int) -> void:
	_attack_power = max(value, 0)

func set_move_speed(value: float) -> void:
	_move_speed = max(value, 0)
	
func set_acceleration(value: float) -> void:
	_acceleration = max(value, 0)

func set_level(value: int) -> void:
	_level = max(value, 1) # Ensure level is at least 1

func set_experience(value: int) -> void:
	_experience = max(value, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
