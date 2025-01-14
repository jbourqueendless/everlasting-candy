extends Control

var _game := preload("res://Scene/Game.tscn") as PackedScene

@onready var MainWorldSelector = $MainWorldSelector
@onready var ExtraWorldSelector = $ExtraWorldSelector


func _enter_world(world: String) -> void:
	global.load_levels(world)
	global.level = global.firstLevel
	get_tree().change_scene_to_packed(_game)
	global.start_music()


func _on_main_world_selected() -> void:
	_enter_world(global.DEFAULT_WORLD)


func _on_extra_worlds_button_pressed() -> void:
	MainWorldSelector.visible = false
	ExtraWorldSelector.visible = true


func _on_back_button_pressed() -> void:
	ExtraWorldSelector.visible = false
	MainWorldSelector.visible = true
