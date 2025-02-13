extends State
class_name Dash_State
@onready var hurt_collision: CollisionShape2D = $"../../HurtBox/CollisionShape2D"
@onready var player_collision: CollisionShape2D = $"../../CollisionShape2D"

func enter():
	handle_animation()
	pass

func exit():
	player.velocity = Vector2.ZERO
	hurt_collision.set_deferred("disabled", false)

func _physics_process(_delta):
	handle_movement(_delta)

func update(_delta):	
	player.velocity = player.direction * player.stats.get_dash_distance()
	hurt_collision.set_deferred("disabled", true)
	player.move_and_slide()
	handle_animation()
	await get_tree().create_timer(0.2).timeout
	state_machine.change_state("Run_State")  # Return to running
	
func handle_movement(delta: float):
	var direction = get_inputs()
	player.velocity = lerp(player.velocity, direction * player.stats.get_move_speed(), delta * player.stats.get_acceleration())

func get_inputs() -> Vector2:
	var input_vector: Vector2
	input_vector = Input.get_vector("left","right","up","down")
	if input_vector != Vector2.ZERO:
		player.direction = input_vector
	return input_vector.normalized()

func handle_animation():
	var direction = player.direction
	
	var animation := ""
	var anim_prefix = "dash"
	var anim_suffix = "down"
	
	if direction.y < -0.5:
		anim_suffix = "up"
	elif direction.y > 0.5:
		anim_suffix = "down"
	
	if direction.x > 0.5:
		anim_suffix += "_right"
	elif direction.x < -0.5:
		anim_suffix += "_left"
		
	animation = anim_prefix + "_" + anim_suffix	
	print(str(direction))
	print(animation)
	if animated_sprite_2d.animation != animation:
		animated_sprite_2d.play(animation)
	pass
