extends CharacterBody2D
@onready var stats : Player_Stats = $"/root/PlayerStats"
var input := Vector2.ZERO
const BOOST_FACTOR = 2.0
const BOOST_COOLDOWN_FACTOR = .5
var canBoost = true;
var inBoost = false;
var direction = Vector2.ZERO

var boost_target_speed = 0.0
var boost_progress = 0.0  # Tracks how far into the boost we are

func _ready():
	var frames = $AnimatedSprite2D.sprite_frames.get_animation_names()
	print(frames)
	if not stats:
		print("warning stats not loaded")
	

func _physics_process(delta: float) -> void:		
	if stats.get_health() <= 0:
		die()
	handle_boost()
	if velocity.length_squared() > 0:
		move_and_slide()
		
func _process(delta: float) -> void:
	if boost_progress < 1.0 and inBoost:
		boost_progress += delta * 3  # Adjust for speed of increase
		stats.set_move_speed(lerp(stats.get_move_speed(), boost_target_speed, boost_progress))

func handle_boost():
	if Input.is_action_just_pressed("boost") and canBoost:
		boost_target_speed = stats.get_move_speed() * BOOST_FACTOR  # Target speed
		boost_progress = 0.0  # Reset progress
		canBoost = false
		inBoost = true
		$BoostTimer.start()
	
func die():
	queue_free()
	
func apply_damage(damage):
	stats.set_health(stats.get_health() - damage)

func _on_hurt_box_hurt(hitbox: Area2D, damage: int) -> void:
	apply_damage(damage)
	print("player was hit by " + hitbox.get_parent().name)

func _on_boost_timer_timeout() -> void:
	boost_target_speed = stats.BASE_SPEED * BOOST_COOLDOWN_FACTOR  # Reduce speed
	boost_progress = 0.0  # Reset for smooth decrease
	inBoost = false
	stats.set_move_speed(stats.BASE_SPEED * BOOST_COOLDOWN_FACTOR)
	$BoostCooldownTimer.start()
	
func _on_boost_cooldown_timer_timeout() -> void:
	stats.set_move_speed(stats.BASE_SPEED)
	canBoost = true
