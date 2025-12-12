extends Node2D

@onready var money_text = $interface/money

var dash_price = 100
var magnet_price = 200
var slow_mod_price = 300

func _physics_process(_delta: float) -> void:
	pass
	money_text.text = str(Global.global_money) + "$"


func _on_button_pressed() -> void:
	if Global.global_money >= dash_price:
		Global.global_money -= dash_price
		Global.dash_unlock = true
		Global.dash_quantity += 3


func _on_magnet_button_pressed() -> void:
	if Global.global_money >= 200:
		Global.global_money -= magnet_price
		Global.magnet += Vector2(0.1, 0)


func _on_slow_mod_button_pressed() -> void:
	if Global.global_money >= slow_mod_price and Global.gravity > 20 :
		Global.global_money -= slow_mod_price
		Global.gravity -= 10
