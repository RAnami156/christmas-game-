extends Node2D
@onready var money_text = $money

func _ready() -> void:
	money_text.text = str(Global.money) + "$"

func _on_play_pressed() -> void:
	money_text.text = str(Global.money) + "$"
	get_tree().change_scene_to_file("res://scene/level.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/shop.tscn")
