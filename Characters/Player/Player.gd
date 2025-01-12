extends KinematicBody2D

const fireball = preload("res://Stuff/Fireball/Fireball.tscn")
const fireball2 = preload("res://Stuff/Fireball/Fireball2.tscn")
const UP = Vector2(0, -1)
const gravity = 20
const max_health = 5
const max_mana = 5

var motion = Vector2()
var speed = 150
var health = max_health
var mana = max_mana
var invincible = false
var right = true
var left = false
var airborne = false
var ReachedFlag = false
var DialougePlaying = false
var SpecialJump = false
var jump_height = -350
var FireballCastingCost = 1

onready var FireballCastTime = get_node("FireballCooldown")
onready var InvincibleTime = get_node("Invincibility")
onready var GameOverTime = get_node("GameOverDelay")
onready var ManaRegenTime = get_node("ManaRegeneration")


func _ready():
 $PauseLayer/Pause.visible = false
 $YouDied/YouDied.visible = false
 FireballCastTime.set_one_shot(false)
 InvincibleTime.set_one_shot(false)
 GameOverTime.set_one_shot(false)

func _physics_process(delta):
 motion.y += gravity
 if health >= 1 and DialougePlaying == false:
  if Input.is_action_pressed("ui_right"):
   motion.x = speed
   $AnimatedSprite.flip_h = false
   if airborne==false and invincible == false:
    $AnimatedSprite.play("Walk")
   right = true
   left = false
  elif Input.is_action_pressed("ui_left"):
   motion.x = -speed
   $AnimatedSprite.flip_h = true
   if airborne==false and invincible == false:
    $AnimatedSprite.play("Walk")
   right = false
   left = true
  else:
   motion.x = 0
   if motion.y==20 and invincible == false:
    $AnimatedSprite.play("Idle")
  if invincible == true and airborne == false:
   $AnimatedSprite.play("Damage")

  if Input.is_action_just_pressed("ui_accept"):
   if FireballCastTime.is_stopped() and mana >= 1:
    mana -= FireballCastingCost
    _Cast_fireball()
    _Cast_fireball_time()
  
  if SpecialJump == true:
   jump_height = -475

  if is_on_floor():
   airborne = false
   if Input.is_action_just_pressed("ui_up"):
    airborne = true
    $JumpSound.play()
    if invincible == false:
     $AnimatedSprite.play("Jump")
    if invincible == true:
     $AnimatedSprite.play("JumpDamage")
    motion.y = jump_height
 if health <= 0:
  $Hitbox/Collision2.disabled = true
  $AnimatedSprite.play("Dead")
  motion.x = 0

#Health Bar
 if health == 5:
  $UI/HealthBar.play("5Hp")
 if health == 4:
  $UI/HealthBar.play("4Hp")
 if health == 3:
  $UI/HealthBar.play("3Hp")
 if health == 2:
  $UI/HealthBar.play("2Hp")
 if health == 1:
  $UI/HealthBar.play("1Hp")
 if health <= 0:
  $UI/HealthBar.play("0Hp")

 #Mana Bar
 if mana >= 6:
  mana -= 1
 if mana == 5:
  $UI/ManaBar.play("5Mana")
 if mana == 4:
  $UI/ManaBar.play("4Mana")
 if mana == 3:
  $UI/ManaBar.play("3Mana")
 if mana == 2:
  $UI/ManaBar.play("2Mana")
 if mana == 1:
  $UI/ManaBar.play("1Mana")
 if mana <= 0:
  $UI/ManaBar.play("0Mana")
 if mana <= -1:
  mana += 1
 
 if DialougePlaying == true:
  $AnimatedSprite.play("Idle")
  motion.x = 0

 motion = move_and_slide(motion, UP)

#Pause
func _input(event):
 if event.is_action_pressed("ui_cancel") and health >= 1:
  var new_pause_state = not get_tree().paused
  get_tree().paused = new_pause_state
  visible = new_pause_state
  $PauseLayer/Pause.visible = true

func _on_Resume_pressed():
 $Click.play()
 get_tree().paused = false
 $PauseLayer/Pause.visible = false

func _on_Retry_pressed():
 get_tree().paused = false
 get_tree().reload_current_scene()

func _on_Return_pressed():
 get_tree().paused = false
 get_tree().change_scene("res://User Interface/Main Menu.tscn")

#Fireball
func _Cast_fireball():
 $FireballCast.play()
 if right==true:
  var fire = fireball.instance()
  get_parent().add_child(fire)
  fire.set_position(get_node("PositionRight").get_global_position())
 if left==true:
  var fire = fireball2.instance()
  get_parent().add_child(fire)
  fire.set_position(get_node("PositionLeft").get_global_position())

func _Cast_fireball_time():
 FireballCastTime.set_wait_time(1)
 FireballCastTime.start()

func _on_FireballCooldown_timeout():
 FireballCastTime.set_one_shot(true)

#Hitbox and Damage values

const Goblin = 1
const BlueGoblin = 1
const blast = 1
const RedGoblin = 2
const PurpleGoblin = 1
const Spike = 1
const Boss = 1

func hit_by_goblin():
 if invincible == false:
  if health >= 1:
   $DamageSound.play()
  health -= Goblin
  invincible = true
  invincible_time_start()

func hit_by_boss():
 if invincible == false:
  if health >= 1:
   $DamageSound.play()
  health -= Boss
  invincible = true
  invincible_time_start()

func hit_by_purple_goblin():
 if invincible == false:
  if health >= 1:
   $DamageSound.play()
  health -= PurpleGoblin
  invincible = true
  invincible_time_start()

func hit_by_spike():
 if invincible == false:
  if health >= 1:
   $DamageSound.play()
  health -= Spike
  invincible = true
  invincible_time_start()

func hit_by_energy_blast():
 if invincible == false:
  if health >= 1:
   $DamageSound.play()
  health -= blast
  mana -= blast
  invincible = true
  invincible_time_start()

func hit_by_blue_goblin():
 if invincible == false:
  if health >= 1:
   $DamageSound.play()
  health -= BlueGoblin
  invincible = true
  invincible_time_start()

func hit_by_red_goblin():
 if invincible == false:
  if health >= 1:
   $DamageSound.play()
  health -= RedGoblin
  invincible = true
  invincible_time_start()

#Invincibility
func invincible_time_start():
 InvincibleTime.set_wait_time(1)
 InvincibleTime.start()

func _on_Invincibility_timeout():
 InvincibleTime.set_one_shot(true)
 invincible = false

#Item Pickups

const heal = 1
const energize = 1

func drink_health_potion():
 if health <= 4:
  $GrabPotionSound.play()
  health += heal

func drink_mana_potion():
 if mana <= 4:
  $GrabPotionSound.play()
  mana += energize

func drink_special_potion():
	$GrabPotionSound.play()
	start_mana_regeneration()
	SpecialJump = true

func _on_Hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
 if health <= 4:
  if area.has_method("picked_by_player_health"):
   area.call("picked_by_player_health")
 if mana <= 4:
  if area.has_method("picked_by_player_mana"):
   area.call("picked_by_player_mana")
 if area.has_method("picked_by_player_special"):
   area.call("picked_by_player_special")

#Death
var repeat = true

func _on_AnimatedSprite_animation_finished():
 if health <= 0:
  gameover_delay()

func gameover_delay():
 GameOverTime.set_wait_time(1)
 GameOverTime.start()

func _on_GameOverDelay_timeout():
 if repeat == true:
  $LoseSound.play()
 $YouDied/YouDied.visible = true

func _on_LoseSound_finished():
 repeat = false

#You Died Menu
func _on_RetryLv_pressed():
 get_tree().reload_current_scene()

func _on_Back_pressed():
 get_tree().change_scene("res://User Interface/Main Menu.tscn")

#Dialogue Triggers
func dialouge_begin():
 DialougePlaying = true

func dialouge_end():
 DialougePlaying = false

#Mana Regeneration
func start_mana_regeneration():
	ManaRegenTime.set_wait_time(5)
	ManaRegenTime.start()

func _on_ManaRegeneration_timeout():
	mana += 1
	ManaRegenTime.set_one_shot(true)
	start_mana_regeneration()

