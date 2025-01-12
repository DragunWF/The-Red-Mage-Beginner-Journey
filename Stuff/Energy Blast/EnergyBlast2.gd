extends Area2D

const speed = 200

var motion = Vector2()
var moving = true

func _ready():
 $AnimatedSprite.play("blast")

func _physics_process(delta):
 if moving==true:
  motion.x -= speed
 motion = motion.normalized() * speed
 position += motion * delta
 if moving==false:
  motion.x = 0

func _on_EnergyBlast_body_entered(body):
 if body.has_method("hit_by_energy_blast"):
  body.call("hit_by_energy_blast")
 queue_free()