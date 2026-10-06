extends Node2D

const cena_char = preload("res://Cenas/personagem.tscn")
const tile_size = 96
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_player(Vector2(9*tile_size,6*tile_size))

func spawn_player(spawn_position: Vector2): # Use Vector3 for 3D
	var player_instance = cena_char.instantiate()
	add_child(player_instance)
	player_instance.global_position = spawn_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
