extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	if "default_snowball" in _body.name:
		Global.player_health -= 20
		print("loose snowball")
