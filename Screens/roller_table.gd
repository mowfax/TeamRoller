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
	var rolling_complete: bool = map_faces()
	if rolling_complete == false:
		result_label.text = check_result(result)
	else:
		result_label.text = "All Slots are filled"
	roll_checked.emit()
	result_label.visible = true
	touch_screen_button.visible = true

func get_mappable_groups() -> Array:
	var return_groups: Array = []
	for slot in Globals.group_free_slots:
		if Globals.group_free_slots[slot] > 0:
			return_groups.append(slot)
		else:
			Globals.group_face_count[slot] = 0
	return return_groups
	
func get_least_filled_group() -> String:
	var least_filled_group: String = ""
	for slot in Globals.group_free_slots:
		if Globals.group_free_slots[slot] > 0:
			if least_filled_group == "":
				least_filled_group = slot
			else:
				if Globals.group_free_slots[slot] > Globals.group_free_slots[least_filled_group]:
					least_filled_group = slot
	prints("least_filled",least_filled_group)
	return least_filled_group

func map_faces() -> bool:
	var rolling_completed = false
	var mappable_groups: Array = get_mappable_groups()
	if mappable_groups.size() == 0:
		rolling_completed = true
	else: 
		var face_split: float = floor(10 / float(mappable_groups.size()))
		prints("Groups:",mappable_groups.size(), "Faces per Group:", face_split, "Filled Faces:", mappable_groups.size() * face_split )
		
		# Assign die face count to groups
		for group in mappable_groups:
			Globals.group_face_count[group] = face_split
		
		# Assign die faces randomly up to each groups face count
		var die_face_to_map: int = 0
		for i in range(mappable_groups.size() * face_split):
			# Get random group from remaining pool
			var mappable_group: bool = false
			var random_group: String
			while (mappable_group == false):
				random_group = mappable_groups[randi() % mappable_groups.size()]
				if Globals.group_face_count[random_group] > 0:
					mappable_group = true
			Globals.die_face_mapping[str(die_face_to_map)] = random_group
			Globals.group_face_count[random_group] -= 1
			die_face_to_map += 1
			
		#for group in mappable_groups:
			#for i in face_split:
				#Globals.die_face_mapping[str(die_face_to_map)] = group
				#die_face_to_map += 1
		while (die_face_to_map < 10):
			Globals.die_face_mapping[str(die_face_to_map)] = get_least_filled_group()
			die_face_to_map += 1
			
		print(Globals.die_face_mapping)
	return rolling_completed

func check_result(result: int) -> String:
	var rolled_group: String = Globals.die_face_mapping[str(result)]
	Globals.group_free_slots[rolled_group] -= 1
	return Globals.group_names[rolled_group]
