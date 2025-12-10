extends Node2D
@onready var speed_text = $stat/speed
@onready var money_text = $mini_shop/money
@onready var score_text = $stat/score
@onready var hp_text = $stat/hp
@onready var size_text = $stat/size
@onready var dash_text = $stat/dash

var time = 0
var default_snowball_scene = preload("res://scene/default_snowball.tscn")
var bomb_snowball_scene = preload("res://scene/bomb_snowball.tscn")
var shield_snowball_scene = preload("res://scene/shield_snowball.tscn")

var spawn_timer = 0.0
var spawn_interval = 4.0  
var screen_width = 0

func _ready():
	spawn_snowball()
	screen_width = get_viewport_rect().size.x
	randomize()
	$player.position = Global.player_position

func _physics_process(delta: float) -> void:
	if Global.player_health <= 0:
		get_tree().change_scene_to_file("res://scene/death_menu.tscn")
	
	speed_text.text = "speed: " + str(Global.player_speed)
	money_text.text = str(Global.money) + "$"
	score_text.text = "score: " + str(Global.score)
	size_text.text = "size:" + str($player.scale)
	
	if Global.dash_unlock:
		dash_text.text = "dash quantity:" + str(Global.dash_quantity)
	else:
		dash_text.text = ""
		
	hp_text.text = "hp: " + str(Global.player_health)
	
	# Динамическая сложность
	update_difficulty()
	
	# Спавн снежков
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_snowball()
		spawn_timer = 0.0
	
func _process(delta):
	updateTimer(delta)

func updateTimer(delta):
	time += delta

func update_difficulty():
	# Чем больше счет - тем быстрее падают снежки
	if Global.score < 10:
		Global.gravity = 200
		spawn_interval = 4.0
	elif Global.score < 25:
		Global.gravity = 300
		spawn_interval = 1.5
	elif Global.score < 50:
		Global.gravity = 400
		spawn_interval = 1.2
	elif Global.score < 100:
		Global.gravity = 500
		spawn_interval = 1.0
	else:
		Global.gravity = 700
		spawn_interval = 0.8

func spawn_snowball():
	var snowball
	var random_chance = randf()
	
	# Шансы зависят от счета
	var bomb_chance = 0.15 + (Global.score * 0.001)  # Начинается с 15%, растет
	var shield_chance = 0.10  # Фиксированный 10%
	
	# Ограничение шанса бомбы максимум 35%
	bomb_chance = min(bomb_chance, 0.35)
	
	# Выбор типа снежка
	if random_chance < shield_chance:
		# 10% шанс на щит
		snowball = shield_snowball_scene.instantiate()
	elif random_chance < shield_chance + bomb_chance:
		# 15-35% шанс на бомбу
		snowball = bomb_snowball_scene.instantiate()
	else:
		# 55-75% дефолтные снежки
		snowball = default_snowball_scene.instantiate()
	
	# Случайная позиция X сверху экрана
	var random_x = randf_range(250, 920)
	snowball.position = Vector2(random_x, -50)
	
	# Добавляем снежок в сцену
	add_child(snowball)
