extends MarginContainer

@onready var roller_table: Node3D = $SubViewportContainer/SubViewport/RollerTable


signal roll_checked

func _ready() -> void:
	roller_table.connect("roll_checked", _on_roll_checked)

func _on_roll_checked() -> void:
	roll_checked.emit()
