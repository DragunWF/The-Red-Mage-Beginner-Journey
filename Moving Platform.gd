extends KinematicBody2D

const up = Vector2(0, -1)
const speed = 75

var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction = right

func _physics_process(delta):
 motion.x = direction.x * speed
 motion = move_and_slide(motion, up)
 
 if is_on_wall():
  if direction == left:
   direction = right
  elif direction == right:
   direction = left