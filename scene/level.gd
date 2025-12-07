extends Node2D

@onready var speed_text = $mini_shop/speed
@onready var money_text = $mini_shop/money

var time = 0

# Preload снежка
var snowball_scene = preload("res://scene/snowball.tscn")

# Настройки спавна
var spawn_timer = 0.0
var spawn_interval = 1.0  # Секунды между спавнами
var screen_width = 0

func _ready():
	screen_width = get_viewport_rect().size.x
	randomize()

func _physics_process(delta: float) -> void:
	speed_text.text = "speed: " + str(Global.player_speed)
	money_text.text = str(Global.money) + "$"
	
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
	var random_x = randf_range(50, screen_width - 50)
	snowball.position = Vector2(random_x, -50)
	
	# Добавляем снежок в сцену
	add_child(snowball)
