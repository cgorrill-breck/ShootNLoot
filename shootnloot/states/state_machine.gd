extends Node
class_name State_Machine
var current_state : State = null
var states = {}

func _ready():
	#initialize the states dictionary with all of the states keyed on the name
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.state_machine = self
	change_state("Idle_State")


func change_state(state_name: String):
	if current_state:
		current_state.exit()
	if state_name in states:
		current_state = states[state_name]
		current_state.enter()

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
