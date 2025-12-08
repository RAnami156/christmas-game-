extends Node2D

@onready var money_text = $interface/money

func _physics_process(delta: float) -> void:
	pass
	money_text.text = str(Global.money) + "$"


func _on_button_pressed() -> void:
	if Global.money >= 100:
		Global.money -= 100
		Global.dash_unlock = true
		Global.dash_quantity += 3
