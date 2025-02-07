extends CharacterBody2D
@onready var stats : Player_Stats = $"/root/PlayerStats"
var input := Vector2.ZERO
const BOOST_FACTOR = 1.5
const BOOST_COOLDOWN_FACTOR = .5
var canBoost = true;

func _ready():
	var frames = $AnimatedSprite2D.sprite_frames.get_animation_names()
	print(frames)
	if not stats:
		print("warning stats not loaded")
	

func _physics_process(delta: float) -> void:		
	if stats.get_health() <= 0:
		die()
	handle_movement(delta)
	handle_boost()
	update_animation()
	if velocity.length_squared() > 0:
		move_and_slide()
	
	
func handle_movement(delta: float):
	var direction = get_inputs()
	velocity = lerp(velocity, direction * stats.get_move_speed(), delta * stats.get_acceleration())

func get_inputs() -> Vector2:
	var input_vector: Vector2
	input_vector = Input.get_vector("left","right","up","down")
	return input_vector.normalized()

func handle_boost():
	if Input.is_action_just_pressed("boost") and canBoost:
		print("boosting: " + str(stats.get_move_speed()))
		stats.set_move_speed(stats.get_move_speed() * BOOST_FACTOR)
		print("boosting: " + str(stats.get_move_speed()))
		canBoost = false
		$BoostTimer.start()
	
func die():
	queue_free()
	
func apply_damage(damage):
	stats.set_health(stats.get_health() - damage)

func _on_hurt_box_hurt(hitbox: Area2D, damage: int) -> void:
	apply_damage(damage)
	print("player was hit by " + hitbox.get_parent().name)

func update_animation():
	var direction = velocity.normalized()
	var anim_prefix = ""
	
	if direction.length_squared() == 0:
		anim_prefix = "idle"
	else:
		anim_prefix = "run"
	
	if Input.is_action_pressed("boost"):
		anim_prefix = "dash"
		
	var anim_suffix = "down"
	
	if direction.y < -0.5:
		anim_suffix = "up"
	elif direction.y > 0.5:
		anim_suffix = "down"
	
	if direction.x > 0.5:
		anim_suffix += "_right"
	elif direction.x < -0.5:
		anim_suffix += "_left"
		
	var new_anim = anim_prefix + "_" + anim_suffix
	
	if $AnimatedSprite2D.animation != new_anim or !$AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play(new_anim)
		
func _on_boost_timer_timeout() -> void:
	stats.set_move_speed(stats.BASE_SPEED * BOOST_COOLDOWN_FACTOR)
	$BoostCooldownTimer.start()
	
func _on_boost_cooldown_timer_timeout() -> void:
	stats.set_move_speed(stats.BASE_SPEED)
	canBoost = true
