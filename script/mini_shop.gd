extends Node2D

@onready var player = $"../player"

var speed_price = 4.0
var hp_price = 6.0
var size_price = 10.0

func _on_speed_button_pressed() -> void:
	if Global.money >= speed_price:
		Global.money -= speed_price
		Global.player_speed += 20


func _on_hp_button_pressed() -> void:
	if Global.money >= hp_price:
		Global.player_health += 5
		Global.money -= hp_price


func _on_size_button_pressed() -> void:
	if Global.money >= size_price:
		player.scale += Vector2(0.05, 0.05)
		Global.player_speed -=20
		Global.money -= size_price
