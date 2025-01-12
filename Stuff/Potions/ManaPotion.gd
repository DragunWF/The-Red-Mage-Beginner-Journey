extends Area2D

var picked = false

func _ready():
 $AnimatedSprite.play("floating")

func _on_ManaPotion_body_entered(body):
 if body.has_method("drink_mana_potion") and body.name == "Player":
  body.call("drink_mana_potion")

func picked_by_player_mana():
 $AnimatedSprite.visible = false
 picked = true

func _on_ManaPotion_body_exited(body):
 if body.name == "Player" and picked == true:
  queue_free()

func _on_ManaPotion_area_exited(area):
 if area.name == "Hitbox" and picked == true:
  queue_free()

