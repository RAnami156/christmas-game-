extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	if "default_snowball" in _body.name:
		Global.player_health -= 20
		print("loose snowball")
	
	#print("Body name: ", _body.name)
	#print("Body scene: ", _body.scene_file_path)  # ← ДОБАВЬ ЭТО
	#print("Body type: ", _body.get_class())
