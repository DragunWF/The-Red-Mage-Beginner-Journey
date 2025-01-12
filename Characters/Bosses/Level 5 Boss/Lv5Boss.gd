extends KinematicBody2D

const EnergyBallR = preload("res://Stuff/Energy Blast/EnergyBlast.tscn")
const EnergyBallL = preload("res://Stuff/Energy Blast/EnergyBlast2.tscn")

const MAX_HEALTH = 100
const GRAVITY = 20
const REDMODESPEED = 150
const PURPLEMODESPEED = 125
const BLUEMODESPEED = 100
const JUMP_HEIGHT = -350
const DAMAGE = 10
const UP = Vector2(0, -1)

var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction = left
var active = false
var health = MAX_HEALTH
var RedModeSpeed = REDMODESPEED
var PurpleModeSpeed = PURPLEMODESPEED
var BlueModeSpeed = BLUEMODESPEED
var jump_height = JUMP_HEIGHT
var damage = DAMAGE

#BossModes
var GreenMode = false
var PurpleMode = false
var RedMode = false
var BlueMode = false

onready var BossSprite = get_node("AnimatedSprite")
onready var ActivationTime = get_node("ActivationTime")
onready var ModeSwitchTime = get_node("ModeSwitchTimeRed")
onready var ModeSwitchTime2 = get_node("ModeSwitchTimePurple")
onready var ModeSwitchTime3 = get_node("ModeSwitchTimeBlue")
onready var JumpTime = get_node("JumpTime")
onready var ShootTime = get_node("ShootTime")
onready var BossDoorTime = get_node("BossOpenDoorTime")


func _ready():
	BossSprite.play("Green")
	ActivationTime.set_one_shot(false)
	ModeSwitchTime.set_one_shot(false)
	ModeSwitchTime2.set_one_shot(false)
	ModeSwitchTime3.set_one_shot(false)
	$CanvasLayer/BossHealth.visible = false
	JumpTime.set_one_shot(false)
	ShootTime.set_one_shot(false)
	BossDoorTime.set_one_shot(false)
	active = false

func dialogue_finished():
	activation_time_start()

func activation_time_start():
	ActivationTime.set_wait_time(1)
	ActivationTime.start()

func _physics_process(delta):
	motion.y += GRAVITY
	if active == true:
		$CanvasLayer/BossHealth.visible = true
		if GreenMode == true:
			BossSprite.play("Green")
		if RedMode == true:
			motion.x = direction.x * RedModeSpeed
			BossSprite.play("Red")
		if PurpleMode == true:
			BossSprite.play("Purple")
			motion.x = direction.x * PurpleModeSpeed
		if BlueMode == true:
			BossSprite.play("Blue")
			motion.x = direction.x * BlueModeSpeed
	motion = move_and_slide(motion, UP)
	if is_on_wall():
		if direction == left:
			direction = right
			BossSprite.flip_h = false
		elif direction == right:
			direction = left
			BossSprite.flip_h = true
	if health <= 0:
		motion.x = 0
		motion.y = -20
		RedMode = false
		PurpleMode = false
		BlueMode = false
		GreenMode = false
		active = false
		BossSprite.play("Death")

func _on_ActivationTime_timeout():
	active = true
	RedMode = true
	mode_switch_purple()
	ActivationTime.set_one_shot(true)

func _on_HitBox_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.has_method("hit_by_boss") and active == true:
		body.call("hit_by_boss")

func mode_switch_red():
	ModeSwitchTime.set_wait_time(3)
	ModeSwitchTime.start()

func mode_switch_purple():
	ModeSwitchTime2.set_wait_time(3)
	ModeSwitchTime2.start()

func mode_switch_blue():
	ModeSwitchTime3.set_wait_time(3)
	ModeSwitchTime3.start()

func _on_ModeSwitchTimeRed_timeout():
	mode_switch_purple()
	RedMode = true
	PurpleMode = false
	BlueMode = false
	ModeSwitchTime.set_one_shot(true)

func _on_ModeSwitchTimePurple_timeout():
	mode_switch_blue()
	RedMode = false
	BlueMode = false
	PurpleMode = true
	jump_and_hop()
	ModeSwitchTime2.set_one_shot(true)

func _on_ModeSwitchTimeBlue_timeout():
	mode_switch_red()
	PurpleMode = false
	RedMode = false
	BlueMode = true
	shoot_energy_blast()
	ModeSwitchTime3.set_one_shot(true)

func jump_and_hop():
	if PurpleMode == true:
		JumpTime.set_wait_time(1.5)
		JumpTime.start()

func _on_JumpTime_timeout():
	if PurpleMode == true:
		motion.y = jump_height
		jump_and_hop()
		$JumpSound.play()
	JumpTime.set_one_shot(true)

func shoot_energy_blast():
	if BlueMode == true:
		ShootTime.set_wait_time(2)
		ShootTime.start()

func _on_ShootTime_timeout():
	shoot_energy_blast()
	if BlueMode == true:
		$BlastSound.play()
		var blast = EnergyBallR.instance()
		get_parent().add_child(blast)
		blast.set_position(get_node("PositionRight").get_global_position())
		$BlastSound.play()
		var blast2 = EnergyBallL.instance()
		get_parent().add_child(blast2)
		blast2.set_position(get_node("PositionLeft").get_global_position())
	ShootTime.set_one_shot(true)

func hit_by_fireball():
	if active == true:
		$DamageSound.play()
		health -= damage
		update_healthbar()

func update_healthbar():
	get_node("CanvasLayer/BossHealth/ProgressBar").set_value(health)

func _on_AnimatedSprite_animation_finished():
	if health <=0:
		$CollisionShape2D.disabled = true
		$CanvasLayer/BossHealth.visible = false
		BossDoorTime.set_wait_time(1)
		BossDoorTime.start()
