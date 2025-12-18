extends CharacterBody2D


#var velocity = Vector2.ZERO
var rotation_speed = 5

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	velocity.y += 0 * delta 
	position += velocity * delta
	rotation += rotation_speed * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if Input.is_action_just_pressed("left click"):
		Global.current_money += 10 
		self.queue_free()


func _on_button_mouse_entered() -> void:
	if Input.is_action_pressed("left click"):
		Global.current_money += 10 
		self.queue_free()

func _on_button_mouse_exited() -> void:
	pass # Replace with function body.
