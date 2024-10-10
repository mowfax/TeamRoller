extends MarginContainer

@onready var info: MarginContainer = $VBoxContainer/ScrollArea/HBoxContainer/Info
@onready var roll: MarginContainer = $VBoxContainer/ScrollArea/HBoxContainer/Roll

func _ready() -> void:
	roll.connect("roll_checked", _on_roll_checked)


func _on_roll_checked() -> void:
	info.update_slots()
