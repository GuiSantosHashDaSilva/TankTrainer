extends Node2D

@export var presetlist: Dictionary [presetname,Char_data] 

enum presetname {preset260,preset280,preset300,preset320}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Arena.presetselecionado = presetlist[presetname.preset260]

func _on_deathstalkerbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/arena.tscn")

func _on_voltarbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/mainmenu.tscn")

func _on_slidercharspeed_value_changed(value: float) -> void:
	match int(value):
		0:
			Arena.presetselecionado = presetlist[presetname.preset260]
		1:
			Arena.presetselecionado = presetlist[presetname.preset280]
		2:
			Arena.presetselecionado = presetlist[presetname.preset300]
		3:
			Arena.presetselecionado = presetlist[presetname.preset320]
