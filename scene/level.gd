extends Node2D

@onready var speed_text = $mini_shop/speed
@onready var money_text = $mini_shop/money
var time = 0

func _physics_process(delta: float) -> void:
	speed_text.text = "speed: " + str(Global.player_speed)
	money_text.text = str(Global.money) + "$"
	#print(roundf(time)) 
	

func _process(delta):
	updateTimer(delta)

func updateTimer(delta):
	time += delta
