extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_ref :CharacterBody2D


func _ready() -> void:
	if player_ref == null : return
	print(player_ref.global_position)

func _physics_process(delta: float) -> void:
	pass

func atk_tail_frenzy():
	get_global_position()
	pass
