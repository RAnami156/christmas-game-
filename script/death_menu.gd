extends Node2D

func _ready() -> void:
	Global.global_money = Global.current_money

func _physics_process(_delta: float) -> void:
	if Global.score > Global.record_score:
		Global.record_score = Global.score
	
	$record.text = "record: " + str(Global.record_score)
	$current_score.text = "current_score: " + str(Global.score)
	$money.text = str(Global.current_money) + "$"


func _on_menu_pressed() -> void:
	Global.player_health = 100
	get_tree().change_scene_to_file("res://scene/menu.tscn")
	Global.current_money = 0


func _on_exit_pressed() -> void:
	get_tree().quit()
