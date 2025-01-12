extends Area2D

var pushed = false
var repeat = false

func _ready():
 $AnimatedSprite.play("unpushed")

func _process(delta):
 if pushed == true:
  $AnimatedSprite.play("pushed")
 if pushed == false:
  $AnimatedSprite.play("unpushed")

func _on_BossButton_body_entered(body):
 if body.name == "Player":
  pushed = true
 if body.name == "Player" and repeat == false:
  $ButtonSound.play()
  repeat = true

func unpush_button():
 pushed = false
 $UnpushSound.play()

