extends CanvasLayer

@onready var exit_button = $"exit-button-anim"

func _physics_process(_delta: float) -> void:
	$Label.text = str(Global.gravity)
	
func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/menu.tscn")


func _on_exit_mouse_entered() -> void:
	exit_button.play("hover")


func _on_exit_mouse_exited() -> void:
	exit_button.play("idle")
