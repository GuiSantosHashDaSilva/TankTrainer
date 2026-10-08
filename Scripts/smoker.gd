extends CharacterBody2D

const TILE_SIZE = 96
const DIAGONAL_SPEED_MULTIPLYER = 1.5

var positionchar
var andando = false
var charspeed = 0.3
@export var sprite: Sprite2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("voltar"):
		get_tree().change_scene_to_file("res://Cenas/menubosses.tscn")

func _physics_process(delta: float) -> void:
	
	var direction := Vector2.ZERO

	if Input.is_action_pressed("supdir"):
		direction = Vector2(1, -1)
	elif Input.is_action_pressed("supesq"):
		direction = Vector2(-1, -1)
	elif Input.is_action_pressed("infdir"):
		direction = Vector2(1, 1)
	elif Input.is_action_pressed("infesq"):
		direction = Vector2(-1, 1)
	else:
		var input := Input.get_vector(
			"esquerda",
			"direita",
			"cima",
	        "baixo"
		)

		direction = Vector2(
			sign(input.x),
			sign(input.y)
		)
	
	andar(direction)

func setup(charatributes:Char_data):
	self.charspeed = charatributes.char_speed
	self.sprite.texture = charatributes.char_sprite

func andar(input_dir):
	if input_dir:
		if andando == false:
			andando = true
			var diagonal = abs(input_dir.x) == abs(input_dir.y)
			var duracao:float = charspeed*DIAGONAL_SPEED_MULTIPLYER if diagonal else charspeed
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir*TILE_SIZE,duracao)
			tween.tween_callback(move_false)

func move_false():
	positionchar = global_position
	andando = false
