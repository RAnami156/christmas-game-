extends Node2D

func _ready() -> void:
	Global.global_money += Global.current_money

func _physics_process(_delta: float) -> void:
	if Global.score > Global.record_score:
		Global.record_score = Global.score
	
	$record.text = "record: " + str(Global.record_score)
	$current_score.text = "current_score: " + str(Global.score)
	$money.text = str(snapped(Global.current_money, 0.1)) + "$" 


func _on_menu_pressed() -> void:
	Global.player_health = 100
	get_tree().change_scene_to_file("res://scene/menu.tscn")
	Global.current_money = 0
	Global.player_speed = 200
	Global.score = 0
	save_game()


func _on_exit_pressed() -> void:
	get_tree().quit()
	save_game()
	
var save_path = "user://savegame.save"

func save_game():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	
	file.store_var(Global.global_money)
