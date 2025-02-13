extends State
class_name Run_State

# Called when the node enters the scene tree for the first time.
func enter():
	var input_vector: Vector2
	input_vector = Input.get_vector("left","right","up","down")
	if input_vector == Vector2.ZERO:
		state_machine.change_state("Idle_State")
	

func exit():
	pass

func _physics_process(_delta):
	handle_movement(_delta)

func update(_delta):
	var input_vector: Vector2
	input_vector = Input.get_vector("left","right","up","down")
	if Input.is_action_just_pressed("dash"):
		state_machine.change_state("Dash_State")
	if input_vector == Vector2.ZERO:
		state_machine.change_state("Idle_State")
	handle_animation()
	pass

	
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
	var anim_prefix = "run"
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
	
	if animated_sprite_2d.animation != animation:
		animated_sprite_2d.play(animation)
	pass
