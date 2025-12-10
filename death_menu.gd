extends Node2D

func _physics_process(_delta: float) -> void:
	if Global.score > Global.record_score:
		Global.record_score = Global.score
	
	$record.text = "record: " + str(Global.record_score)
	$current_score.text = "current_score: " + str(Global.score)
