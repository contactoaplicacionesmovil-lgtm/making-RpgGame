extends Node2D

func _ready() -> void:
	$P1/Body/AnimationPlayer.play("idle")
	$P2/Body/AnimationPlayer.play("idle_2")
	$P3/Body/AnimationPlayer.play("idle")


func _on_button_back_choose_pressed() -> void:
	$"../StartScreen".visible = true
	$".".visible = false
	

func _on_button_p_1_pressed() -> void:
	Global.charChosen = 1
	Global.attack = 1 # ?
	Global.miningStrength = 1 # ?
	Global.charSpeed = 1 # ?
	$".".visible = false
	$"../Game".visible = true


func _on_button_p_2_pressed() -> void:
	Global.charChosen = 2
	Global.attack = 1 # ?
	Global.miningStrength = 1 # ?
	Global.charSpeed = 1 # ?
	$".".visible = false
	$"../Game".visible = true


func _on_button_p_3_pressed() -> void:
	Global.charChosen = 3
	Global.attack = 1 # ?
	Global.miningStrength = 1 # ?
	Global.charSpeed = 1 # ?
	$".".visible = false
	$"../Game".visible = true
