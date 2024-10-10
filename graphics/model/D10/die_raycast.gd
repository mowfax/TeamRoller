extends RayCast3D

@export var opposite_side: int

func _ready() -> void:
	add_exception(%Dice_d10_LP)
