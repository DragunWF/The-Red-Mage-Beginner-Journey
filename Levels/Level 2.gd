extends Node2D

func _ready():
 $Signs/DrainMana/Label.visible = false

#Drain Mana Sign
func _on_DrainMana_body_entered(body):
 if body.name == "Player":
  $Signs/DrainMana/Label.visible = true

func _on_DrainMana_body_exited(body):
 if body.name == "Player":
  $Signs/DrainMana/Label.visible = false

func _on_Flag_body_entered(body):
 if body.name == "Player":
  get_tree().change_scene("res://Levels/Level 3.tscn")

