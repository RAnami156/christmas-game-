extends Node2D

var velocity = Vector2.ZERO
var gravity = 150
var rotation_speed = 300

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	rotation += rotation_speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	self.queue_free()
	pass
