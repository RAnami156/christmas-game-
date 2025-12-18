extends AnimatedSprite2D

var start_pos = Vector2(1150, 212)
var end_pos = Vector2(147, 212)
var speed = 100.0  # Скорость движения
var moving_right = false  # Направление движения

func _ready():
	position = start_pos

func _process(delta):
	if moving_right:
		# Двигаемся влево
		position.x -= speed * delta
		flip_h = false  # Зеркально
		
		# Достигли левой точки
		if position.x <= end_pos.x:
			position.x = end_pos.x
			moving_right = false
	else:
		# Двигаемся вправо
		position.x += speed * delta
		flip_h = true  # Нормально
		
		# Достигли правой точки
		if position.x >= start_pos.x:
			position.x = start_pos.x
			moving_right = true
