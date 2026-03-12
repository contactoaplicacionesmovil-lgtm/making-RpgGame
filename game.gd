extends Node2D

@export var level1: PackedScene
@export var level2: PackedScene
@export var level3: PackedScene
var gameEnded: bool = false

func _ready() -> void:
	Global.weaponInUse = 0

func _process(delta: float) -> void:
	if Global.health == 3:
		$UI/HealthBar/H1.visible = true
		$UI/HealthBar/H2.visible = true
		$UI/HealthBar/H3.visible = true
	if Global.health == 2:
		$UI/HealthBar/H1.visible = true
		$UI/HealthBar/H2.visible = true
		$UI/HealthBar/H3.visible = false
	if Global.health == 1:
		$UI/HealthBar/H1.visible = true
		$UI/HealthBar/H2.visible = false
		$UI/HealthBar/H3.visible = false
	if Global.health <= 0:
		$UI/HealthBar/H1.visible = false
		$UI/HealthBar/H2.visible = false
		$UI/HealthBar/H3.visible = false
		if gameEnded == false:
			$UI/AnimationPlayer.play("game_over")
			await $UI/AnimationPlayer.animation_finished
			gameEnded = true
	$UI/Menu/LabelPointNumbers.text ="Level points: "+ str(Global.lPoints)
	$UI/ExpBar/Label.text = "L"+ str(Global.currentLevel)
	
	if Global.xp ==0:
		$UI/ExpBar/Exp0.visible = true
		$UI/ExpBar/Exp1.visible = false
		$UI/ExpBar/Exp2.visible = false
		$UI/ExpBar/Exp3.visible = false
	if Global.xp ==2:
		$UI/ExpBar/Exp0.visible = true
		$UI/ExpBar/Exp1.visible = true
		$UI/ExpBar/Exp2.visible = false
		$UI/ExpBar/Exp3.visible = false
	if Global.xp ==6:
		$UI/ExpBar/Exp0.visible = true
		$UI/ExpBar/Exp1.visible = true
		$UI/ExpBar/Exp2.visible = true
		$UI/ExpBar/Exp3.visible = false
	if Global.xp ==10:
		$UI/ExpBar/Exp0.visible = true
		$UI/ExpBar/Exp1.visible = true
		$UI/ExpBar/Exp2.visible = true
		$UI/ExpBar/Exp3.visible = true
		
	if Global.charChosen == 1 and Global.weaponInUse == 0:
		$UI/CurrentWeapon/Sword.visible = true
		$UI/CurrentWeapon/Hand.visible = false
		$UI/CurrentWeapon/Basket.visible = false
		$UI/CurrentWeapon/Pic.visible = false
	if Global.charChosen == 2 and Global.weaponInUse == 0:
		$UI/CurrentWeapon/Sword.visible = false
		$UI/CurrentWeapon/Hand.visible = true
		$UI/CurrentWeapon/Basket.visible = false
		$UI/CurrentWeapon/Pic.visible = false
	if Global.charChosen == 3 and Global.weaponInUse == 0:
		$UI/CurrentWeapon/Sword.visible = false
		$UI/CurrentWeapon/Hand.visible = false
		$UI/CurrentWeapon/Basket.visible = true
		$UI/CurrentWeapon/Pic.visible = false
		
	if Global.weaponInUse == 1:
		$UI/CurrentWeapon/Sword.visible = false
		$UI/CurrentWeapon/Hand.visible = false
		$UI/CurrentWeapon/Basket.visible = false
		$UI/CurrentWeapon/Pic.visible = true
		

func create_new_level():
	var new_level
	var levePicked = randi_range(1,3)
	if levePicked ==1:
		new_level = level1.instantiate()
	if levePicked ==2:
		new_level = level2.instantiate()
	if levePicked ==3:
		new_level = level3.instantiate()
	call_deferred("add_child", new_level)
	new_level.position = self.position
	

func _on_button_menu_pressed() -> void:
	$UI/Menu.visible = true


func _on_button_game_back_pressed() -> void:
	$UI/Menu.visible = false


func _on_button_attack_up_pressed() -> void:
	Global.attack +=1
	Global.lPoints -=1


func _on_button_mining_up_pressed() -> void:
	Global.miningStrength +=1
	Global.lPoints -=1
	

func _on_button_speed_up_pressed() -> void:
	Global.charSpeed +=1
	Global.lPoints -=1
