extends Node2D

@onready var money_text = $interface/money
@onready var freeze_pic = $TimeFreeze
@onready var magnet_pic = $Magnet
@onready var dash_pic = $Dash

var dash_price = 100
var magnet_price = 50
var slow_mod_price = 30

func _physics_process(_delta: float) -> void:
	$money.text = str(Global.global_money) + "$"
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


func _on_slow_mod_button_mouse_entered() -> void:
	freeze_pic.scale += Vector2(0.5, 0.5)


func _on_slow_mod_button_mouse_exited() -> void:
	freeze_pic.scale -= Vector2(0.5, 0.5)


func _on_button_mouse_entered() -> void:
	dash_pic.scale += Vector2(0.5, 0.5)


func _on_button_mouse_exited() -> void:
	dash_pic.scale -= Vector2(0.5, 0.5)


func _on_magnet_button_mouse_entered() -> void:
	magnet_pic.scale += Vector2(0.5, 0.5)


func _on_magnet_button_mouse_exited() -> void:
		magnet_pic.scale -= Vector2(0.5, 0.5)
