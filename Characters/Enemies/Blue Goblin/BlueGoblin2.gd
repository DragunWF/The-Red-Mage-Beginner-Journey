extends KinematicBody2D

const EnergyBlast = preload("res://Stuff/Energy Blast/EnergyBlast2.tscn")
const up = Vector2(0, -1)
const gravity = 20

var motion = Vector2()

onready var EnergyBlastCooldown = get_node("EnergyBlastTime")

func _ready():
 $AnimatedSprite.play("Idle")
 EnergyBlastCooldown.set_one_shot(false)
 cast_energy_blast_time()

func _physics_process(delta):
 motion.y += gravity
 motion = move_and_slide(motion, up)
 
func _on_HitBox_body_entered(body):
 if body.has_method("hit_by_blue_goblin"):
  body.call("hit_by_blue_goblin")

func cast_energy_blast_time():
 EnergyBlastCooldown.set_wait_time(2)
 EnergyBlastCooldown.start()

func _on_EnergyBlastTime_timeout():
 EnergyBlastCooldown.set_one_shot(true)
 cast_energy_blast()
 cast_energy_blast_time()

func cast_energy_blast():
 $EnergyBlastSound.play()
 var blast = EnergyBlast.instance()
 get_parent().add_child(blast)
 blast.set_position(get_node("Position2D").get_global_position())

func hit_by_fireball():
 queue_free()