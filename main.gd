extends Node2D

func _ready() -> void:
	$StartScreen/UI/AnimationPlayer.play("PickaxeFloat")
	Global.health = 3
	Global.lPoints = 0
	Global.currentLevel = 0
	Global.xp = 0
	
	

func _on_button_play_game_pressed() -> void:
	$StartScreen.visible = false
	$CharSelect.visible = true


func _on_button_quit_game_pressed() -> void:
	get_tree().reload_current_scene() #reset the game


func _on_button_game_over_pressed() -> void:
	get_tree().reload_current_scene() #reset the game
