extends Node2D

@onready var speed_text = $stat/speed
@onready var money_text = $mini_shop/money
@onready var score_text = $stat/score
@onready var hp_text = $stat/hp
@onready var size_text = $stat/size
#@onready var hp_text = 

var time = 0

var snowball_scene = preload("res://scene/snowball.tscn")

var spawn_timer = 0.0
var spawn_interval = 4.0  
var screen_width = 0

func _ready():
	screen_width = get_viewport_rect().size.x
	randomize()

func _physics_process(delta: float) -> void:
	#print(Global.player_size)
	speed_text.text = "speed: " + str(Global.player_speed)
	money_text.text = str(Global.money) + "$"
	score_text.text = "score: " + str(Global.score)
	hp_text.text = "hp: " + str(Global.player_health)
	size_text.text = "size:" + str($player.scale)
	
	#Global.player_size = $player.scale
	
	
	# Спавн снежков
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_snowball()
		spawn_timer = 0.0
	
func _process(delta):
	updateTimer(delta)

func updateTimer(delta):
	time += delta

func spawn_snowball():
	var snowball = snowball_scene.instantiate()
	
	# Случайная позиция X сверху экрана
	var random_x = randf_range(250, 920)
	snowball.position = Vector2(random_x, -50)
	
	# Добавляем снежок в сцену
	add_child(snowball)
