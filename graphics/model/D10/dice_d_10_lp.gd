extends RigidBody3D

@onready var raycasts = $Raycasts.get_children()

var start_pos
var roll_strength = 50

signal roll_finished(result: int)
signal roll_started()

func _ready() -> void:
	start_pos = global_position
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_roll()
		
func _roll() -> void:
	roll_started.emit()
	# reset state
	sleeping = false
	freeze = false
	transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	# random rotation
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2* PI)) * transform.basis
	
	# random throw impulse
	var throw_vector = Vector3(randf_range(-1,1),0,randf_range(-1,1)).normalized()
	angular_velocity = throw_vector * roll_strength / 2
	apply_central_impulse(throw_vector * roll_strength)
	


func _on_sleeping_state_changed() -> void:
	if sleeping:
		for raycast in raycasts:
			if raycast.is_colliding():
				print("Colliding")
				roll_finished.emit(raycast.opposite_side)
