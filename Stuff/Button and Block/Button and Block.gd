extends Node2D

var pushed = false
var repeat = true

func _ready():
 $Button/ButtonSprite.play("button")
 $Block/Block1.play("closed")
 $Block/Block2.play("closed")
 $Block/Block3.play("closed")
 $Block/Block4.play("closed")

func _process(delta):
 if pushed == true:
  $Button/ButtonSprite.play("pushed")
  $Block/Block1.play("opened")
  $Block/Block2.play("opened")
  $Block/Block3.play("opened")
  $Block/Block4.play("opened")
  $Block/CollisionShape2D.disabled = true
 if pushed == true and repeat == true:
  $Button/PushSound.play()
  repeat = false
 if pushed == false:
  $Button/ButtonSprite.play("button")
  $Block/Block1.play("closed")
  $Block/Block2.play("closed")
  $Block/Block3.play("closed")
  $Block/Block4.play("closed")
  $Block/CollisionShape2D.disabled = false

func _on_Button_body_entered(body):
 if body.name == "Player":
  pushed = true

func unpush_button():
 pushed = false

