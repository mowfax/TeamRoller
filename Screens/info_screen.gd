extends MarginContainer

@onready var group_1_slots: Label = $MarginContainer/GridContainer/Group1Slots
@onready var group_2_slots: Label = $MarginContainer/GridContainer/Group2Slots
@onready var group_3_slots: Label = $MarginContainer/GridContainer/Group3Slots
@onready var group_4_slots: Label = $MarginContainer/GridContainer/Group4Slots
@onready var group_5_slots: Label = $MarginContainer/GridContainer/Group5Slots
@onready var group_slots: Array = [group_1_slots, group_2_slots, group_3_slots, group_4_slots, group_5_slots]
@onready var touch_screen_button_edit: TouchScreenButton = $MarginContainer/TouchScreenButtonEdit
@onready var touch_screen_button_save: TouchScreenButton = $MarginContainer/TouchScreenButtonSave


func _ready() -> void:
	update_slots()

func update_slots() -> void:
	for i in range(5):
		group_slots[i].text = str(Globals.group_free_slots.get(str(i+1)))


func _on_touch_screen_button_edit_pressed() -> void:
	var slots_readonly: Array = get_tree().get_nodes_in_group("Slots_ReadOnly")
	for label in slots_readonly:
		label.visible = false
	
	var slots_readwrite: Array = get_tree().get_nodes_in_group("Slots_ReadWrite")
	for button in slots_readwrite:
		button.visible = true
	
	for i in range(5):
		slots_readwrite[i].text = str(Globals.group_free_slots.get(str(i+1)))
	
	touch_screen_button_edit.visible = false
	touch_screen_button_save.visible = true


func _on_touch_screen_button_save_pressed() -> void:
	var slots_readwrite: Array = get_tree().get_nodes_in_group("Slots_ReadWrite")
	for button in slots_readwrite:
		button.visible = false
		
	var slots_readonly: Array = get_tree().get_nodes_in_group("Slots_ReadOnly")
	for label in slots_readonly:
		label.visible = true
	
	for i in range(5):
		Globals.group_free_slots[str(i+1)] = int(slots_readwrite[i].text)
	
	update_slots()
	
	touch_screen_button_save.visible = false
	touch_screen_button_edit.visible = true
