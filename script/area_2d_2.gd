extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "default_snowball":
		Global.player_health -= 20
		print("loose snowball")
