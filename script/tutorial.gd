extends Node2D

@onready var exit_anim = $"exit-button-anim"


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu.tscn")


func _on_exit_mouse_entered() -> void:
	exit_anim.play("hover")


func _on_exit_mouse_exited() -> void:
	exit_anim.play("idle")
