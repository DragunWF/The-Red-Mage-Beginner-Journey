extends StaticBody2D

var open = false
var closed = true

func ready():
 $AnimatedBlock1.play("closed")
 $AnimatedBlock2.play("closed")
 $AnimatedBlock3.play("closed")
 $AnimatedBlock4.play("closed")

func _process(delta):
 if closed == true and open == false:
  $CollisionShape2D.disabled = false
 if closed == false and open == true:
  $CollisionShape2D.disabled = true

func open_door():
 closed = false
 open = true
 $AnimatedBlock1.play("open")
 $AnimatedBlock2.play("open")
 $AnimatedBlock3.play("open")
 $AnimatedBlock4.play("open")

func close_door():
 closed = true
 open = false
 $AnimatedBlock1.play("closed")
 $AnimatedBlock2.play("closed")
 $AnimatedBlock3.play("closed")
 $AnimatedBlock4.play("closed")
