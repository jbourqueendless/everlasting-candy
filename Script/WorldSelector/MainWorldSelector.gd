extends Control

signal main_world_selected
signal show_extra_worlds

@onready var CandyWrapperButton = %CandyWrapperButton

func _ready() -> void:
	CandyWrapperButton.grab_focus()


func _on_candy_wrapper_button_pressed() -> void:
	main_world_selected.emit()


func _on_extra_worlds_button_pressed() -> void:
	show_extra_worlds.emit()


func _on_visibility_changed() -> void:
	if self.visible and CandyWrapperButton:
		CandyWrapperButton.grab_focus()
