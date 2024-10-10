extends Node3D

@onready var result_label: Label = $CanvasLayer/Label
@onready var touch_screen_button: TouchScreenButton = $CanvasLayer/TouchScreenButton
@onready var dice_10: Node3D = $Dice_10/Dice_d10_LP


signal roll_checked()

func _ready() -> void:
	dice_10.connect("roll_finished", _on_die_roll_finished)
	dice_10.connect("roll_started", _on_die_roll_started)
	
func _on_die_roll_started():
	result_label.visible = false
	touch_screen_button.visible = false

func _on_die_roll_finished(result: int):
	map_faces()
	result_label.text = check_result(result)
	roll_checked.emit()
	result_label.visible = true
	touch_screen_button.visible = true

func get_mappable_groups() -> Array:
	var return_groups: Array = []
	for slot in Globals.group_free_slots:
		if Globals.group_free_slots[slot] > 0:
			return_groups.append(slot)
	return return_groups

func map_faces() -> void:
	var mappable_groups: Array = get_mappable_groups()
	var face_split: float = floor(10 / float(mappable_groups.size()))
	var face_split_remainder = fmod(10, mappable_groups.size())
	prints(mappable_groups.size(), face_split, face_split_remainder)
	
	# Assign die faces equally between remaining restaurants
	var die_face_to_map: int = 0
	for group in mappable_groups:
		for i in face_split:
			Globals.die_face_mapping[str(die_face_to_map)] = group
			die_face_to_map += 1
	while (die_face_to_map < 10):
		Globals.die_face_mapping[str(die_face_to_map)] = mappable_groups[randi() % mappable_groups.size()] 
		die_face_to_map += 1
		
	print(Globals.die_face_mapping)

func check_result(result: int) -> String:
	var rolled_group: String = Globals.die_face_mapping[str(result)]
	Globals.group_free_slots[rolled_group] -= 1
	return Globals.group_names[rolled_group]
