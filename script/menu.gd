extends Node2D
@onready var money_text = $money
@onready var anim_buttonPlay = $"play-button-anim"
@onready var anim_buttonExit = $"exit-button-anim"

var save_path = "user://savegame.save"

func _ready() -> void:
	load_game()
	money_text.text = str(snapped(Global.global_money, 0.1)) + "$"
	$"record score".text = "your record: " + str(Global.record_score)
	print("Loaded - Money:", Global.global_money, "Record:", Global.record_score)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/level.tscn")

func _on_exit_pressed() -> void:
	save_game()
	get_tree().quit()

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/shop.tscn")

func _on_shop_mouse_entered() -> void:
	$Backround2.play("shop")

func _on_shop_mouse_exited() -> void:
	$Backround2.play("default")

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Global.global_money)
	file.store_var(Global.record_score) 
	file.close()

func load_game():
	if not FileAccess.file_exists(save_path):
		Global.global_money = 0
		Global.record_score = 0
		return
	
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		Global.global_money = file.get_var()
		Global.record_score = file.get_var()
		file.close()

func _on_play_mouse_entered() -> void:
	anim_buttonPlay.play("play hover")

func _on_play_mouse_exited() -> void:
	anim_buttonPlay.play("play idle")

func _on_exit_mouse_entered() -> void:
	anim_buttonExit.play("hover")

func _on_exit_mouse_exited() -> void:
	anim_buttonExit.play("idle")


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/tutorial.tscn")


func _on_tutorial_mouse_entered() -> void:
	$Message.visible = false


func _on_tutorial_mouse_exited() -> void:
	$Message.visible = true
