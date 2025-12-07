extends Node2D

var price = 4.0





func _on_speed_button_pressed() -> void:
	if Global.money >= price:
		Global.money -= price
		Global.player_speed += 20
