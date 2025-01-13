extends Node2D

const DEFAULT_WORLD := "res://TileMap/"

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
	audio.play()
	audio.finished.connect(audio.play)

func _input(event):
	if event.is_action_pressed("ui_fullscreen"):
		var win_full = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE if win_full else DisplayServer.MOUSE_MODE_HIDDEN)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if win_full else DisplayServer.WINDOW_MODE_FULLSCREEN)

## Load a series of numbered scenes from the given directory.
## Each must be a TileMapLayer node.
func load_levels(tilemap_dir: String):
	_levels.clear()

	var levelrx := RegEx.new()
	levelrx.compile("^(\\d+).tscn$")

	var level_paths: Array[String]
	var dir := DirAccess.open(tilemap_dir)
	dir.list_dir_begin()
	var file := dir.get_next()
	while file:
		var rxmatch := levelrx.search(file)
		if rxmatch:
			level_paths.append(file)

		file = dir.get_next()

	level_paths.sort_custom(func (a: String, b: String): return a.naturalnocasecmp_to(b) < 0)
	for path in level_paths:
		var l := load(tilemap_dir.path_join(path)) as PackedScene
		_levels.append(l)

	lastLevel = _levels.size() - 1

func instantiate_level() -> Node:
	return _levels[level].instantiate()

func wrapp(pos := Vector2.ZERO):
	return Vector2(wrapf(pos.x, 0.0, 144.0), wrapf(pos.y, 0.0, 144.0))
