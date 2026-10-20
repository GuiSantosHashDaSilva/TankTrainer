extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("hud_timer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func atualizar_texto_contador(novo_texto: String):
	self.show()
	self.text = novo_texto
func sumir():
	self.hide()
