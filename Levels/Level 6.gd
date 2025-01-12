extends Node2D

onready var Dialouge1 = get_node("DialougeLayer/Dialouge")
onready var Dialouge2 = get_node("DialougeLayer/Dialouge2")
onready var Dialouge3 = get_node("DialougeLayer/Dialouge3")
onready var Dialouge4 = get_node("DialougeLayer/Dialouge4")
onready var PlayerCamera = get_node("Player/Camera2D")
onready var BlueMageCamera = get_node("BlueMage/BlueMageCamera")

func _ready():
	Dialouge1.visible = false
	Dialouge2.visible = false
	Dialouge3.visible = false
	Dialouge4.visible = false

func _on_Trigger_body_entered(body):
	if body.has_method("dialouge_begin"):
		body.call("dialouge_begin")
		dialouge_start()

func dialouge_start():
	PlayerCamera.current = false
	BlueMageCamera.current = true
	Dialouge1.visible = true

func dialouge_end():
	get_node("Player").dialouge_end()
	BlueMageCamera.current = false
	PlayerCamera.current = true
	$DialogueTrigger/Trigger.queue_free()

func _on_Next_pressed():
	$ButtonSound.play()
	Dialouge1.visible = false
	Dialouge2.visible = true

func _on_Next2_pressed():
	$ButtonSound.play()
	Dialouge2.visible = false
	Dialouge3.visible = true

func _on_Next3_pressed():
	$ButtonSound.play()
	Dialouge3.visible = false
	Dialouge4.visible = true

func _on_Next4_pressed():
	$ButtonSound.play()
	Dialouge4.visible = false
	dialouge_end()

func _on_Flag_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Levels/Epilogue.tscn")
