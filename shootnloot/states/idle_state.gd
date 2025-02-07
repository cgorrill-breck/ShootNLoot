extends State
class_name Idle_State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var player: CharacterBody2D = $"../.."


func enter():
	print("entered idle")
	handle_animation()
	pass

func exit():
	print("left idle")
	pass

func update(_delta):
	var input_vector: Vector2
	input_vector = Input.get_vector("left","right","up","down")
	if input_vector != Vector2.ZERO:
		print("changed state to run")
		state_machine.change_state("Run_State")
		
	handle_animation()
	pass
	
func physics_update(_delta):
	player.velocity = Vector2.ZERO
	pass

func handle_animation():
	var direction = player.direction
	
	var animation := ""
	var anim_prefix = "idle"
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
