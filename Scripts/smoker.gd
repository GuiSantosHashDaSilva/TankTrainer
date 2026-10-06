extends CharacterBody2D

var andando = false
var input_dir
const tile_size = 96


func _physics_process(delta: float) -> void:
	input_dir = Vector2.ZERO
	if Input.is_action_just_pressed("cima"):
		input_dir = Vector2(0,-1)
		andar()
	elif Input.is_action_just_pressed("baixo"):
		input_dir = Vector2(0,1)
		andar()
	elif Input.is_action_just_pressed("esquerda"):
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
			tween.tween_property(self, "position", position + input_dir*tile_size,0.3)
			tween.tween_callback(move_false)

func move_false():
	andando = false
