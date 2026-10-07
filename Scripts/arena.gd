extends Node2D

const CENA_CHAR = preload("res://Cenas/personagem.tscn")
const CENA_BOSS = preload("res://Cenas/deathstalker.tscn")
const TILE_SIZE = 96
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_player(Vector2(9*TILE_SIZE,6*TILE_SIZE))
	spawn_boss(Vector2(9*TILE_SIZE,3*TILE_SIZE))

func spawn_player(spawn_position: Vector2): # Use Vector3 for 3D
	var player_instance = CENA_CHAR.instantiate()
	add_child(player_instance)
	player_instance.global_position = spawn_position
	
func spawn_boss(spawn_position: Vector2):
	var boss_instance = CENA_BOSS.instantiate()
	add_child(boss_instance)
	boss_instance.global_position = spawn_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
