extends CharacterBody2D

#var velocity = Vector2.ZERO
var rotation_speed = 5

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	velocity.y += Global.gravity * delta
	position += velocity * delta
	rotation += rotation_speed * delta


func _on_area_2d_body_entered(_body: Node2D) -> void:
	Global.player_health -= 30
	self.queue_free()
	pass
