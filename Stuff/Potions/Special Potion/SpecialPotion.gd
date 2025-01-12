extends Area2D

var picked = false

func _ready():
	$AnimatedSprite.play("idle")

func picked_by_player_special():
	$AnimatedSprite.visible = false
	picked = true

func _on_SpecialPotion_body_entered(body):
	if body.has_method("drink_special_potion"):
		body.call("drink_special_potion")

func _on_SpecialPotion_body_exited(body):
	if body.name == "Player" and picked == true:
		queue_free()

func _on_SpecialPotion_area_exited(area):
	if area.name == "HitBox" and picked == true:
		queue_free()
