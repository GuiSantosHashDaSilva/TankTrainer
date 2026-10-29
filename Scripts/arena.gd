extends Node2D

class_name Arena

const CENA_CHAR = preload("res://Cenas/personagem.tscn")
const CENA_BOSS = preload("res://Cenas/deathstalker.tscn")
const TILE_SIZE = 96

@export var labelht: Label
@export var labeldodge: Label
@export var labelttotaltail: Label

var arena_ref = self
var player_ref: CharacterBody2D
var boss_
static var presetselecionado: Char_data


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_player(Vector2(9*TILE_SIZE,6*TILE_SIZE))
	spawn_boss(Vector2(9*TILE_SIZE,3*TILE_SIZE))
	
	#print(player_ref.global_position)

func spawn_player(spawn_position: Vector2): # Use Vector3 for 3D
	var player_instance = CENA_CHAR.instantiate()
	player_instance.setup(presetselecionado)
	add_child(player_instance)
	player_instance.global_position = spawn_position
	player_ref = player_instance
	
func spawn_boss(spawn_position: Vector2):
	var boss_instance = CENA_BOSS.instantiate()
	boss_instance.player_ref = player_ref
	add_child(boss_instance)
	boss_instance.global_position = spawn_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	labelht.text = "Hits Tomados: "+str(player_ref.hits_tomados)
	labeldodge.text = "Desviadas: "+str(player_ref.hits_desviados)
