extends Node2D

@onready var speed_text = $stat/speed
@onready var money_text = $mini_shop/money
@onready var score_text = $stat/score
@onready var hp_text = $stat/hp
@onready var size_text = $stat/size
@onready var dash_text = $stat/dash
#@onready var hp_text = 

var time = 0

var snowball_scene = preload("res://scene/default_snowball.tscn")

var spawn_timer = 0.0
var spawn_interval = 4.0  
var screen_width = 0

func _ready():
	spawn_snowball()
	screen_width = get_viewport_rect().size.x
	randomize()
	$player.position = Global.player_position

func _physics_process(delta: float) -> void:
	#print(Global.player_size)
	speed_text.text = "speed: " + str(Global.player_speed)
	money_text.text = str(Global.money) + "$"
	score_text.text = "score: " + str(Global.score)
	size_text.text = "size:" + str($player.scale)
	if Global.dash_unlock:
		dash_text.text = "dash quantity:" + str(Global.dash_quantity)
	else:
		dash_text.text = ""
		
	#await get_tree().create_timer(0.5).timeout
	hp_text.text = "hp: " + str(Global.player_health)
	#Global.player_size = $player.scale
	#Global.player_position = $player.position
	
	
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
