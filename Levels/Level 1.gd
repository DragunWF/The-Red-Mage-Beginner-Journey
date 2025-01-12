extends Node2D

func _ready():
 $Movement/Label.visible = false
 $Jump/Label.visible = false
 $PauseSign/Label.visible = false
 $FireSpell/Label.visible = false
 $ManaCost/Label.visible = false
 $HealthSign/Label.visible = false
 $PotionSign/Label.visible = false
 $GoalSign/Label.visible = false
 $GreenEnemy/Label.visible = false

#Movement Sign
func _on_Movement_body_entered(body):
 if body.name=="Player":
  $Movement/Label.visible = true

func _on_Movement_body_exited(body):
 if body.name=="Player":
  $Movement/Label.visible = false

#Jump Sign
func _on_Jump_body_entered(body):
 if body.name=="Player":
  $Jump/Label.visible = true

func _on_Jump_body_exited(body):
 if body.name=="Player":
  $Jump/Label.visible = false

#Pause Sign
func _on_PauseSign_body_entered(body):
 if body.name=="Player":
  $PauseSign/Label.visible = true

func _on_PauseSign_body_exited(body):
 if body.name=="Player":
  $PauseSign/Label.visible = false

#Fireball Spell Sign
func _on_FireSpell_body_entered(body):
 if body.name=="Player":
  $FireSpell/Label.visible = true

func _on_FireSpell_body_exited(body):
 if body.name=="Player":
  $FireSpell/Label.visible = false

#Mana Cost Sign
func _on_ManaCost_body_entered(body):
 if body.name=="Player":
  $ManaCost/Label.visible = true

func _on_ManaCost_body_exited(body):
 if body.name=="Player":
  $ManaCost/Label.visible = false

#Health Potion Sign
func _on_HealthSign_body_entered(body):
 if body.name=="Player":
  $HealthSign/Label.visible = true

func _on_HealthSign_body_exited(body):
 if body.name=="Player":
  $HealthSign/Label.visible = false

#Potion Sign
func _on_PotionSign_body_entered(body):
 if body.name=="Player":
  $PotionSign/Label.visible = true

func _on_PotionSign_body_exited(body):
 if body.name=="Player":
  $PotionSign/Label.visible = false

#Goal Sign
func _on_GoalSign_body_entered(body):
 if body.name=="Player":
  $GoalSign/Label.visible = true

func _on_GoalSign_body_exited(body):
 if body.name=="Player":
  $GoalSign/Label.visible = false

#Flag
func _on_Flag_body_entered(body):
 if body.name=="Player":
  get_tree().change_scene("res://Levels/Level 2.tscn")

#Green Enemy Sign
func _on_GreenEnemy_body_entered(body):
 if body.name == "Player":
  $GreenEnemy/Label.visible = true

func _on_GreenEnemy_body_exited(body):
 if body.name == "Player":
  $GreenEnemy/Label.visible = false

