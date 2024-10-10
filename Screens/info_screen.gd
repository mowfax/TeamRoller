extends MarginContainer

@onready var group_1_slots: Label = $MarginContainer/GridContainer/Group1Slots
@onready var group_2_slots: Label = $MarginContainer/GridContainer/Group2Slots
@onready var group_3_slots: Label = $MarginContainer/GridContainer/Group3Slots
@onready var group_4_slots: Label = $MarginContainer/GridContainer/Group4Slots
@onready var group_5_slots: Label = $MarginContainer/GridContainer/Group5Slots
@onready var group_slots: Array = [group_1_slots, group_2_slots, group_3_slots, group_4_slots, group_5_slots]


func _ready() -> void:
	update_slots()

func update_slots() -> void:
	for i in range(5):
		group_slots[i].text = str(Globals.group_free_slots.get(str(i+1)))
