extends KinematicBody2D

const up = Vector2(0, -1)
const gravity = 20
const speed = 100

var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction = right
var airborne = false
var repeat = true

onready var JumpCooldown = get_node("JumpTime")

func _ready():
 $AnimatedSprite.play("walk")
 JumpCooldown.set_one_shot(false)
 jump_time_start()

func _physics_process(delta):
 motion.y += gravity
 motion.x = direction.x * speed
 motion = move_and_slide(motion, up)
 airborne = true
 
 if is_on_floor():
  airborne = false
  if airborne == false:
   $AnimatedSprite.play("walk")
  if airborne == true:
   $AnimatedSprite.play("jump")

 if is_on_wall():
  if direction == left:
   direction = right
  elif direction == right:
   direction = left
 if direction==right:
  $AnimatedSprite.flip_h = false
 if direction==left:
  $AnimatedSprite.flip_h = true

func jump_and_hop():
 airborne = true
 motion.y = -300

func hit_by_fireball():
 queue_free()

func jump_time_start():
 repeat = true
 JumpCooldown.set_wait_time(1)
 JumpCooldown.start()

func _on_JumpTime_timeout():
 JumpCooldown.set_one_shot(true)
 $JumpSound.play()
 jump_and_hop()
 jump_time_start()

func _on_AreaBox_body_entered(body):
 if body.has_method("hit_by_purple_goblin"):
  body.call("hit_by_purple_goblin")
