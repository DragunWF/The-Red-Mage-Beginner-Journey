extends Control

func _ready():
 $Music.play()
 $StartMenu.visible = true
 $Title.visible = true
 $SelectLevel.visible = false
 $SelectLevelTitle.visible = false
 $SelectReturn.visible = false
 $Prologue.visible = false

#Start Menu
func _on_Start_pressed():
 $Click.play()
 $StartMenu.visible = false
 $Title.visible = false
 $Prologue.visible = true

func _on_Select_pressed():
 $Click.play()
 $StartMenu.visible = false
 $Title.visible = false
 $SelectLevel.visible = true
 $SelectLevelTitle.visible = true
 $SelectReturn.visible = true

func _on_Quit_pressed():
 get_tree().quit()

#Select Level Menu
func _on_Lv1_pressed():
 get_tree().change_scene("res://Levels/Level 1.tscn")

func _on_Lv2_pressed():
 get_tree().change_scene("res://Levels/Level 2.tscn")

func _on_Lv3_pressed():
 get_tree().change_scene("res://Levels/Level 3.tscn")

func _on_Lv4_pressed():
 get_tree().change_scene("res://Levels/Level 4.tscn")

func _on_Lv5_pressed():
 get_tree().change_scene("res://Levels/Level 5.tscn")

func _on_Return_pressed():
 $Click.play()
 $StartMenu.visible = true
 $Title.visible = true
 $SelectLevel.visible = false
 $SelectLevelTitle.visible = false
 $SelectReturn.visible = false

#Start Game
func _on_StartGame_pressed():
	get_tree().change_scene("res://Levels/Level 1.tscn")
