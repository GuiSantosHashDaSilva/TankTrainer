extends Label

var qtd_desviada = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("hud_desviada")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func esquivou():
	qtd_desviada += 1
	self.text = "Desviadas: " + str(qtd_desviada)
