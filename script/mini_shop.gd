extends Node2D

@onready var player = $"../player"
@onready var speed_button = $improvements/speed/speed_button
@onready var hp_button = $improvements/hp/hp_button
@onready var size_button = $improvements/size/size_button



var speed_price = 4.0
var hp_price = 6.0
var size_price = 10.0

func _physics_process(_delta: float) -> void:
	speed_button.text = str(snapped(speed_price,0.1)) + "$"
	hp_button.text = str(snapped(hp_price,0.1)) + "$"
	size_button.text = str(snapped(size_price,0.1)) + "$"
	


func _on_speed_button_pressed() -> void:
	if Global.current_money >= speed_price:
		Global.current_money -= speed_price
		Global.player_speed += 20
		speed_price += speed_price * 0.4


func _on_hp_button_pressed() -> void:
	if Global.current_money >= hp_price:
		Global.player_health += 5
		Global.current_money -= hp_price
		hp_price += hp_price * 0.2


func _on_size_button_pressed() -> void:
	if Global.current_money >= size_price:
		player.scale += Vector2(0.10, 0.10)
		Global.player_speed -= 20
		Global.current_money -= size_price
		size_price += size_price * 0.4
