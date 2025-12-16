extends Node2D
@onready var speed_text = $stat/speed
@onready var money_text = $mini_shop/money
@onready var score_text = $stat/score
@onready var hp_text = $stat/hp
@onready var size_text = $stat/size
@onready var dash_text = $stat/dash
@onready var anim_level = $AnimationPlayer
@onready var levels = $Label

var time = 0
var default_snowball_scene = preload("res://scene/default_snowball.tscn")
var bomb_snowball_scene = preload("res://scene/bomb_snowball.tscn")
var shield_snowball_scene = preload("res://scene/shield_snowball.tscn")

var spawn_timer = 0.0
var spawn_interval = 4.0  
var screen_width = 0

func _ready():
	level_anim()
	screen_width = get_viewport_rect().size.x
	randomize()
	$player.position = Global.player_position
	spawn_snowball()
	$backround/AnimatedLevelBackround.play("default")
	await $backround/AnimatedLevelBackround.animation_finished
	$backround/AnimatedLevelBackround.visible = false

func _physics_process(delta: float) -> void:
	$player/interface/Label2.text = str(spawn_interval)
	if Global.player_health <= 0:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scene/death_menu.tscn")
		return
	
	levels.text ="Level " + str(Global.level)
	speed_text.text = str(Global.player_speed)
	money_text.text = str(snapped(Global.current_money, 0.1)) + "$"
	score_text.text = "score: " + str(Global.score)
	size_text.text =str($player.scale)
	hp_text.text = str(Global.player_health)
	
	if Global.dash_unlock:
		dash_text.text = "dash quantity:" + str(Global.dash_quantity)
	else:
		dash_text.text = ""
	
	update_difficulty()
	level_anim()
	#anim_2026()
	
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_snowball()
		spawn_timer = 0.0

func _process(delta):
	updateTimer(delta)

func updateTimer(delta):
	time += delta

func update_difficulty():

	if Global.score > 5 and Global.score < 15:
		Global.gravity = 200
		spawn_interval = 3.5
		$backround/AnimatedLevelBackround.play("default")
		
		
	elif Global.score > 15 and Global.score < 30:
		Global.gravity = 280
		spawn_interval = 3.0
		
	elif Global.score > 30 and Global.score < 50:
		Global.gravity = 350
		spawn_interval = 2.8
		
	elif Global.score > 50 and Global.score < 75:
		Global.gravity = 400
		spawn_interval = 2.6
		
	elif Global.score > 75 and Global.score < 100:
		Global.gravity = 500
		spawn_interval = 2.5
		
	elif Global.score > 100:
		Global.gravity = 550
		spawn_interval = 2.5
		
		
func spawn_snowball():
	var snowball
	var random_chance = randf()
	
	var bomb_chance = 0.05 + (Global.score * 0.003)  # Начинается с 5%
	var shield_chance = 0.03 + (Global.score * 0.001)  # Начинается с 3%
	
	# Ограничения
	bomb_chance = clamp(bomb_chance, 0.05, 0.25)  # Максимум 25%
	shield_chance = clamp(shield_chance, 0.03, 0.12)  # Максимум 12%
	
	# Выбор типа снежка
	if random_chance < shield_chance:
		snowball = shield_snowball_scene.instantiate()
		snowball.name = "shield_snowball" + str(snowball.get_instance_id())
	elif random_chance < shield_chance + bomb_chance:
		snowball = bomb_snowball_scene.instantiate()
		snowball.name = "bomb_snowball" + str(snowball.get_instance_id())
	else:
		snowball = default_snowball_scene.instantiate()
		snowball.name = "default_snowball_" + str(snowball.get_instance_id()) 
	

	var random_x = randf_range(250, 920)
	snowball.position = Vector2(random_x, -50)
	
	add_child(snowball)
	
var save_path = "user://savegame.save"

func save_game():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	
	file.store_var(Global.global_money)
	file.store_var(Global.record_score)

func load_game():
	var file =  FileAccess.open(save_path,FileAccess.READ)
	
	Global.global_money = file.get_var(Global.global_money)
	Global.record_score = file.get_var(Global.record_score)


func level_anim():
	if Global.score == 5 :
		anim_level.play("levels")
		levels.visible = true
		Global.level = 1
		
	elif Global.score == 15 :
		anim_level.play("levels")
		levels.visible = true
		Global.level = 2
		
	elif Global.score == 30 :
		anim_level.play("levels")
		levels.visible = true
		Global.level = 3
		
	elif Global.score == 50 :
		anim_level.play("levels")
		levels.visible = true
		Global.level = 4
		
	elif Global.score == 75 :
		anim_level.play("levels")
		levels.visible = true
		Global.level = 5
		
	elif Global.score == 100:
		anim_level.play("levels")
		levels.visible = true
		Global.level = "max"
	else:
		levels.visible = false
		#anim_level.active = false
	
	
#func anim_2026():
	#if Global.score == 5 :
		#$backround/AnimatedLevelBackround.play("default")
		#
	#elif Global.score == 15 :
		#$backround/AnimatedLevelBackround.play("default")
		#
	#elif Global.score == 30 :
		#$backround/AnimatedLevelBackround.play("default")
		#
	#elif Global.score == 50 :
		#$backround/AnimatedLevelBackround.play("default")
		#
	#elif Global.score == 75 :
		#$backround/AnimatedLevelBackround.play("default")
		#
	#elif Global.score == 100:
		#$backround/AnimatedLevelBackround.play("default")
	#else:
		#$backround/AnimatedLevelBackround.visible = false


func _on_speed_button_mouse_entered() -> void:
	print("ghhg")
	$shop/Speed.size += Vector2(0.1, 0.1)
