extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_bossselect_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/menubosses.tscn")

func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/menucredito.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()
