extends Node2D

func _ready():
 $NewEnemyType/Label.visible = false

#New Enemy Type Sign
func _on_NewEnemyType_body_entered(body):
 if body.name == "Player":
  $NewEnemyType/Label.visible = true

func _on_NewEnemyType_body_exited(body):
 if body.name == "Player":
  $NewEnemyType/Label.visible = false

#Flag
func _on_Flag_body_entered(body):
 if body.name == "Player":
  get_tree().change_scene("res://Levels/Level 5.tscn")

