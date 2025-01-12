extends Node2D

var BossDoorClosed = false
var RightArea = false
var LeftArea = false

onready var BossCamera = get_node("Lv5Boss/BossCamera")
onready var PlayerCamera = get_node("Player/Camera2D")
onready var Dialouge1 = get_node("DialougeLayer/Dialouge")
onready var Dialouge2 = get_node("DialougeLayer/Dialouge2")
onready var Dialouge3 = get_node("DialougeLayer/Dialouge3")
onready var DialougeCollisionTrigger = get_node("DialougeTrigger/CollisionShape2D")
onready var BossDoorCollision = get_node("CloseBossDoor/CollisionShape2D")
onready var Boss = get_node("Lv5Boss")

func _ready():
 $Prepare/Label.visible = false
 $SpecialPotionDrink/Label.visible = false
 Dialouge1.visible = false
 Dialouge2.visible = false
 Dialouge3.visible = false
 RightArea = false
 LeftArea = true

func _process(delta):
 if BossDoorClosed == true:
  get_node("CloseBossDoor/CollisionShape2D").disabled = true

#Prepare for a boss fight sign
func _on_Prepare_body_entered(body):
 if body.name == "Player":
  $Prepare/Label.visible = true

func _on_Prepare_body_exited(body):
 if body.name == "Player":
  $Prepare/Label.visible = false

#Flag
func _on_Flag_body_entered(body):
 if body.name == "Player":
  get_tree().change_scene("res://Levels/Level 6.tscn")

#Boss Button
func _on_BossButton_body_entered(body):
 if body.name == "Player":
  get_node("BossDoors/BossDoor").open_door()

#Dialouge
func dialouge_start():
 Dialouge1.visible = true
 get_node("Player").dialouge_begin()
 PlayerCamera.current = false
 BossCamera.current = true

func _on_DialougeTrigger_body_entered(body):
 if body.name == "Player":
  dialouge_start()

#Close Boss Door Trigger
func _on_CloseBossDoor_body_entered(body):
 if body.name == "Player":
  get_node("BossDoors/BossDoor").close_door()
  get_node("BossButtons/BossButton").unpush_button()
  get_node("Button and Blocks/Button and Block").unpush_button()
  BossDoorClosed = true
  BossDoorCollision.disabled = true

#Buttons
func _on_Next_pressed():
 $ButtonSound.play()
 Dialouge1.visible = false
 Dialouge2.visible = true

func _on_Next2_pressed():
 $ButtonSound.play()
 Dialouge2.visible = false
 Dialouge3.visible = true

func _on_Next3_pressed():
 $ButtonSound.play()
 Dialouge3.visible = false
 get_node("Player").dialouge_end()
 BossCamera.current = false
 PlayerCamera.current = true
 DialougeCollisionTrigger.disabled = true
 Boss.dialogue_finished()

#Special Potion Sign
func _on_SpecialPotionDrink_body_entered(body):
	if body.name == "Player":
		$SpecialPotionDrink/Label.visible = true

func _on_SpecialPotionDrink_body_exited(body):
	if body.name == "Player":
		$SpecialPotionDrink/Label.visible = false

func open_boss_door():
	$BossDoors/BossDoor2.open_door() 

func _on_BossOpenDoorTime_timeout():
	open_boss_door()
