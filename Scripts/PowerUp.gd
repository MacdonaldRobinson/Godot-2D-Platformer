extends Area2D

func _ready():
	$AnimatedSprite.play("Idle")	


func _on_PowerUp_body_entered(body):
	if "Player" in body.name:
		body.powerup()
		queue_free()
