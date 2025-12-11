extends CanvasLayer

func _physics_process(_delta: float) -> void:
	$Label.text = str(Global.gravity)
func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu.tscn")
