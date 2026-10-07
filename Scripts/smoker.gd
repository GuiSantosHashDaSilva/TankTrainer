extends CharacterBody2D

const TILE_SIZE = 96

var positionchar
var andando = false
var input_dir


func _physics_process(delta: float) -> void:
	positionchar = global_position
	input_dir = Vector2.ZERO
	if Input.is_action_pressed("cima"):
		input_dir = Vector2(0,-1)
		andar()
	elif Input.is_action_pressed("baixo"):
		input_dir = Vector2(0,1)
		andar()
	elif Input.is_action_pressed("esquerda"):
		input_dir = Vector2(-1,0)
		andar()
	elif Input.is_action_pressed("direita"):
		input_dir = Vector2(1,0)
		andar()
	move_and_slide()

func andar():
	if input_dir:
		if andando == false:
			andando = true
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir*TILE_SIZE,0.3)
			#print(global_position)
			tween.tween_callback(move_false)

func move_false():
	andando = false
