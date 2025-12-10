extends CharacterBody2D

@onready var take_box = $Area2D/take_box
@onready var shield_anim = $shield

func _physics_process(delta: float) -> void:
	if Global.shield:
		shield_anim.visible = true
	else:
		shield_anim.visible = false
		
	if Global.player_speed <= 0:
		Global.player_speed = 0
		
	take_box.scale = Global.magnet
	$killer.scale = Global.magnet
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


func _on_area_2d_body_entered(_body: Node2D) -> void:
	Global.score += 1
	Global.money += 2 
	
	#if  _body.name == "default_snowball":
		#print("take default")

	if _body.name == "bomb_snowball" and Global.shield == false:
		Global.player_health -= 30
		print("take bomb")
	if _body.name == "bomb_snowball" and Global.shield:
		print("shield works!!!")
		
	if _body.name == "shield_snowball":
		print("take shield")
		
		Global.shield = true
		print(Global.shield)
		
		await get_tree().create_timer(5).timeout
		
		Global.shield = false
		print(Global.shield)
	
