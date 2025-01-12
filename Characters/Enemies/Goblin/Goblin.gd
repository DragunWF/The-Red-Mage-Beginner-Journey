extends KinematicBody2D

const up = Vector2(0, -1)
const gravity = 20
const speed = 75

var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction = right

func _ready():
 $AnimatedSprite.play("Walk")

func _physics_process(delta):
 motion.y += gravity
 motion.x = direction.x * speed
 motion = move_and_slide(motion, up)
 
 if is_on_wall():
  if direction == left:
   direction = right
  elif direction == right:
   direction = left
 if direction==right:
  $AnimatedSprite.flip_h = false
 if direction==left:
  $AnimatedSprite.flip_h = true

func hit_by_fireball():
 queue_free()

func _on_Hit_body_entered(body):
 if body.has_method("hit_by_goblin"):
  body.call("hit_by_goblin")
