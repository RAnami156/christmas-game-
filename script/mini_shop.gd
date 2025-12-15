extends Node2D

@onready var player = $"../player"
@onready var speed_button = $"../shop/speed"
@onready var hp_button = $"../shop/hp"
@onready var size_button = $"../shop/size"



var speed_price = 4.0
var hp_price = 6.0
var size_price = 10.0

func _physics_process(_delta: float) -> void:
	speed_button.text = str(snapped(speed_price, 0.1)) + "$"
	hp_button.text = str(snapped(hp_price, 0.1)) + "$"
	size_button.text = str(snapped(size_price, 0.1)) + "$"
	


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



func _on_speed_button_mouse_entered() -> void:
	$"../shop/Speed".scale += Vector2(0.5, 0.5)


func _on_speed_button_mouse_exited() -> void:
	$"../shop/Speed".scale -= Vector2(0.5, 0.5)


func _on_hp_button_mouse_entered() -> void:
	$"../shop/Hearts".scale += Vector2(0.5, 0.5)


func _on_hp_button_mouse_exited() -> void:
	$"../shop/Hearts".scale -= Vector2(0.5, 0.5)


func _on_size_button_mouse_entered() -> void:
	$"../shop/Size".scale += Vector2(0.5, 0.5)


func _on_size_button_mouse_exited() -> void:
	$"../shop/Size".scale -= Vector2(0.5, 0.5)
