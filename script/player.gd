extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if Global.player_speed <= 0:
		Global.player_speed = 0
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction := Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * Global.player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, Global.player_speed)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	Global.score += 1
	Global.money += 2 
	Global.player_health += 20
	print(Global.score)
