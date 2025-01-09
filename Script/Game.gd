extends Node2D

var tmpath := "res://TileMap/"
enum {TILE_WALL = 0, TILE_PLAYER = 1, TILE_GOOBER = 2}
var NodeTileMap: TileMap

var ScenePlayer = load("res://Scene/Player.tscn")
var SceneGoober = load("res://Scene/Goober.tscn")
var SceneExplo = load("res://Scene/Explosion.tscn")

@onready var NodeGoobers := $Goobers
@onready var NodeAudioWin := $Audio/Win
@onready var NodeAudioLose := $Audio/Lose
@onready var NodeSprite := $Sprite2D

var clock := 0.0
var delay := 1.5
var check := false
var change := false

func _ready():
	global.Game = self
	
	if global.level == global.firstLevel or global.level == global.lastLevel:
		NodeSprite.frame = 0 if global.level == global.firstLevel else 3
		NodeSprite.visible = true
		var p = ScenePlayer.instantiate()
		p.position = Vector2(72, 85)
		p.scale.x = -1 if randf() < 0.5 else 1
		p.set_script(null)
		add_child(p)
	
	MapLoad()
	MapStart()

func _process(delta):
	clock += delta
	# title screen is the first level, and "game complete" screen is the last level:
	if btn.p("jump") and (global.level == global.firstLevel or (global.level == global.lastLevel  and clock > 0.5)):
		global.level = posmod(global.level + 1, global.lastLevel + 1)
		DoChange()
	
	MapChange(delta)

func MapLoad():
	var nxtlvl = min(global.level, global.lastLevel)
	var tm = load(tmpath + str(nxtlvl) + ".tscn").instantiate()
	tm.name = "TileMap"
	add_child(tm)
	NodeTileMap = tm

func MapStart():
	print("--- MapStart: Begin ---")
	print("global.level: ", global.level)
	for pos in NodeTileMap.get_used_cells(0):
		var id = NodeTileMap.get_cell_source_id(0, pos)
		match id:
			TILE_WALL:
				print(pos, ": Wall")
				# Use random wall tile from 3×3 tileset to make levels look less repetitive
				var atlas = Vector2(randi_range(0, 2), randi_range(0, 2))
				NodeTileMap.set_cell(0, pos, TILE_WALL, atlas)
			TILE_PLAYER:
				print(pos, ": Player")
				# Add live player to the scene
				var inst = ScenePlayer.instantiate()
				inst.position = NodeTileMap.map_to_local(pos) + Vector2(4, 0)
				self.add_child(inst)
				# Remove static player tile from the tile map
				NodeTileMap.set_cell(0, pos, -1)
			TILE_GOOBER:
				print(pos, ": Goober")
				# Add live goober to the scene
				var inst = SceneGoober.instantiate()
				inst.position = NodeTileMap.map_to_local(pos) + Vector2(4, 1)
				NodeGoobers.add_child(inst)
				# Remove static goober tile from the tile map
				NodeTileMap.set_cell(0, pos, -1)
	print("--- MapStart: End ---")

func MapChange(delta):
	# if its time to change scene
	if change:
		delay -= delta
		if delay < 0:
			DoChange()
		return # skip the rest if change == true
	
	# should i check?
	if check:
		check = false
		var count = NodeGoobers.get_child_count()
		print("Goobers: ", count)
		if count == 0:
			Win()

func Lose():
	change = true
	NodeAudioLose.play()
	NodeSprite.visible = true
	NodeSprite.frame = 2
	global.level = max(0, global.level - 1)

func Win():
	change = true
	NodeAudioWin.play()
	NodeSprite.visible = true
	global.level = min(global.lastLevel, global.level + 1)
	print("Level Complete!, change to level: ", global.level)

func DoChange():
	change = false
	get_tree().reload_current_scene()

func Explode(arg : Vector2):
	var xpl = SceneExplo.instantiate()
	xpl.position = arg
	add_child(xpl)
