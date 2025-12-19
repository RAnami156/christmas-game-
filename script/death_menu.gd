extends Node2D

@onready var exit_anim = $"exit-button-anim"

var save_path = "user://savegame.save"

func _ready() -> void:
	load_game()  
	Global.global_money += Global.current_money
	Global.loose = false 

func _physics_process(_delta: float) -> void:
	if Global.record_score == null:
		Global.record_score = 0
	if Global.score > Global.record_score:
		Global.record_score = Global.score
	
	$record.text = "record: " + str(Global.record_score)
	$current_score.text = "current_score: " + str(Global.score)
	$money.text = str(snapped(Global.current_money, 0.1)) + "$" 

func _on_menu_pressed() -> void:
	save_game() 
	Global.player_health = 100
	Global.current_money = 0
	Global.player_speed = 200
	Global.score = 0
	get_tree().change_scene_to_file("res://scene/menu.tscn")

func _on_exit_pressed() -> void:
	save_game()
	get_tree().quit()

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


func _on_exit_mouse_entered() -> void:
	exit_anim.play("hover")


func _on_exit_mouse_exited() -> void:
	exit_anim.play("idle")


func _on_menu_mouse_entered() -> void:
	$AnimatedSprite2D.play("hover")


func _on_menu_mouse_exited() -> void:
	$AnimatedSprite2D.play("default")
