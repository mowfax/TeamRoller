extends Node


@onready var last_changed := $GruppenInput
@onready var not_last_changed := $GruppengroesseInput


func _on_gruppen_input_value_changed(value: int) -> void:
	last_changed = $GruppenInput
	not_last_changed = $GruppengroesseInput
	_update_personen()


func _on_gruppengroesse_input_value_changed(value: int) -> void:
	last_changed = $GruppengroesseInput
	not_last_changed = $GruppenInput
	_update_personen()


func _on_personen_input_value_changed(value: int) -> void:
	not_last_changed.set_value_no_signal(value / last_changed.value)


func _update_personen() -> void:
	$PersonenInput.min_value = last_changed.value
	$PersonenInput.max_value = last_changed.value * not_last_changed.max_value
	$PersonenInput.custom_arrow_step = last_changed.value
	$PersonenInput.set_value_no_signal($GruppenInput.value * $GruppengroesseInput.value)
