extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if Global.player_speed <= 0:
		Global.player_speed = 0
		
	#MOVEMENT
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction := Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * Global.player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, Global.player_speed)
		
	#DASH
	if Global.dash_unlock and Global.dash_quantity > 0:
		if Input.is_action_just_pressed("left"):
			position = Vector2(268, 596)
			Global.player_position = position
			Global.dash_quantity -= 1
		elif Input.is_action_just_pressed("right"):
			position = Vector2(861, 596)
			Global.player_position = position
			Global.dash_quantity -= 1
		else:
			Global.player_position = position

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	Global.score += 1
	Global.money += 2 
	Global.player_health += 20
	print(Global.score)
