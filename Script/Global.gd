extends Node2D

const DEFAULT_WORLD := "res://CandyWrapper/"

var _levels: Array[PackedScene]
var level := 0
const firstLevel := 0
var lastLevel: int
var Game

var OST = load("res://Audio/OST.mp3")
var audio

func _ready():
	load_levels(DEFAULT_WORLD)

	await get_tree().create_timer(0.1).timeout

	audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = OST

func _input(event):
	if event.is_action_pressed("ui_fullscreen"):
		var win_full = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE if win_full else DisplayServer.MOUSE_MODE_HIDDEN)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if win_full else DisplayServer.WINDOW_MODE_FULLSCREEN)

## Lists scenes in the given resource directory, accounting for the fact that,
## when exported, resource files are renamed, but must be loaded by their
## original name.
##
## Returns the original basename of each scene in the given directory.
##
## TODO: in Godot 4.4, use ResourceLoader.list_directory()
##  https://docs.godotengine.org/en/latest/classes/class_resourceloader.html#class-resourceloader-method-list-directory
func _list_scenes(path: String) -> Array[String]:
	var scenes: Array[String]
	var dir := DirAccess.open(path)
	
	dir.list_dir_begin()
	var file := dir.get_next()
	while file:
		if file.ends_with(".tscn.remap"):
			scenes.append(file.left(-len(".remap")))
		elif file.ends_with(".tscn"):
			scenes.append(file)
		file = dir.get_next()
	dir.list_dir_end()

	return scenes

## Load a series of numbered scenes from the given directory.
## Each must be a TileMapLayer node.
func load_levels(tilemap_dir: String):
	_levels.clear()

	var scenes := _list_scenes(tilemap_dir)
	scenes.sort_custom(func (a: String, b: String): return a.naturalnocasecmp_to(b) < 0)

	for name in scenes:
		var l := load(tilemap_dir.path_join(name)) as PackedScene
		_levels.append(l)

	lastLevel = _levels.size() - 1

func instantiate_level() -> Node:
	return _levels[level].instantiate()

func start_music():
	audio.play()

func stop_music():
	audio.stop()

func wrapp(pos := Vector2.ZERO):
	return Vector2(wrapf(pos.x, 0.0, 144.0), wrapf(pos.y, 0.0, 144.0))
