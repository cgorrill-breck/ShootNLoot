extends CharacterBody2D
@export var stats : Player_Stats

var input : Vector2
const BOOST_FACTOR = 1.5
func _ready():
	stats = Player_Stats.new()

func _physics_process(delta: float) -> void:		
	if stats.get_health() <= 0:
		die()
	handle_movement(delta)
	handle_boost()
	move_and_slide()
	
	
func handle_movement(delta: float):
	var direction = get_inputs()
	velocity = lerp(velocity, direction * stats.get_move_speed(), delta * stats.get_accelleration())

func get_inputs() -> Vector2:
	var input_vector: Vector2
	input_vector = Input.get_vector("left","right","up","down")
	return input_vector.normalized()

func handle_boost():
	if Input.is_action_just_pressed("boost"):
		stats.set_move_speed(stats.get_move_speed() * BOOST_FACTOR)
	
func die():
	queue_free()
	
func apply_damage(damage):
	stats.set_health(stats.get_health() - damage)

func _on_hurt_box_hurt(hitbox: Area2D, damage: int) -> void:
	apply_damage(damage)
	print("player was hit by " + hitbox.get_parent().name)
