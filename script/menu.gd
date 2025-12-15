extends Node2D
@onready var money_text = $money

func _ready() -> void:
	load_game()
	money_text.text = str(snapped(Global.global_money, 0.1)) + "$"

func _on_play_pressed() -> void:
	money_text.text = str(Global.global_money) + "$"
	get_tree().change_scene_to_file("res://scene/level.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/shop.tscn")


func _on_shop_mouse_entered() -> void:
	$Backround2.play("shop")
	#print("nigga")



func _on_shop_mouse_exited() -> void:
	$Backround2.play("default")

var save_path = "user://savegame.save"

func save_game():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	
	file.store_var(Global.global_money)

func load_game():
	if not FileAccess.file_exists(save_path):
		return  
	
	var file = FileAccess.open(save_path, FileAccess.READ)

	if file:
		Global.global_money = file.get_var()
		file.close()
