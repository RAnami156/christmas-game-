extends Node2D
@onready var money_text = $money

func _ready() -> void:
	money_text.text = str(Global.global_money) + "$"

func _on_play_pressed() -> void:
	money_text.text = str(Global.global_money) + "$"
	get_tree().change_scene_to_file("res://scene/level.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/shop.tscn")


func _on_shop_mouse_entered() -> void:
	$Backround2.play("shop")
	print("nigga")



func _on_shop_mouse_exited() -> void:
	$Backround2.play("default")
