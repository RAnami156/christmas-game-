extends CharacterBody2D

@onready var take_box = $Area2D/take_box
@onready var shield_anim = $shield
@onready var anim_effects = $effects
@onready var anim = $AnimationPlayer
@onready var text = $minus


var is_dashing = false

func _ready() -> void:
	$plus.visible = false
	

func _physics_process(delta: float) -> void:
	#print(Global.money_plus) #FOR TESTS
	
	if Input.is_action_just_pressed("ui_select"):
		get_tree().paused = not get_tree().paused
		#$PauseMenu.visible = get_tree().paused  # Показать/скрыть меню
		return
	
	$plus.text = "+" + str(Global.money_plus) + "$"
	text.text = "-" + str(Global.loose_count) + "hp"
	update_difficulty()
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
	if Global.dash_unlock and Global.dash_quantity > 0 and not is_dashing:
		if Input.is_action_just_pressed("left"):
			dash_to(Vector2(268, 596))
			Global.dash_quantity -= 1
		elif Input.is_action_just_pressed("right"):
			dash_to(Vector2(861, 596))
			Global.dash_quantity -= 1
	
	Global.player_position = position
	move_and_slide()
	
	if Global.loose:
		text.visible = true
		anim.play("loose")
		await anim.animation_finished
		Global.loose = false
	else:
		text.visible = false
	

func dash_to(target_pos: Vector2):
	is_dashing = true
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)  
	tween.set_trans(Tween.TRANS_CUBIC)  
	tween.tween_property(self, "position", target_pos, 0.2) 
	
	await tween.finished
	is_dashing = false
	move_and_slide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	#print("play")
	
	if "default_snowball" in _body.name:
		Global.loose_count = 20
		anim_effects.play("+1")
		
	if "bomb_snowball" in _body.name and Global.shield == false:
			Global.player_health -= 30
			Global.loose_count = 30
			print("take bomb")
			
	if "bomb_snowball" in _body.name and Global.shield:
		Global.current_money += 5
		Global.shield = false
		print("shield works!!!")
		
	if "shield_snowball" in _body.name:
		print("take shield")
		
		Global.shield = true
		print(Global.shield)
		
		await get_tree().create_timer(20).timeout
		
		Global.shield = false
		print(Global.shield)
	
	#money_increase
	Global.score += 1
	$plus.visible = true
	Global.current_money += Global.money_plus
	
func update_difficulty():
	if Global.score > 5 and Global.score < 15:
		Global.money_plus = 1.2
		
	elif Global.score > 15 and Global.score < 30:
		Global.money_plus = 1.5
		
	elif Global.score > 30 and Global.score < 50:
		Global.money_plus = 2
		
	elif Global.score > 50 and Global.score < 75:
		Global.money_plus = 3
		
	elif Global.score > 75 and Global.score < 100:
		Global.money_plus = 3.5
		
	elif Global.score > 100:
		Global.money_plus = 5
