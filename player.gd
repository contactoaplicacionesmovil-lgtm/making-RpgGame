extends CharacterBody2D

@export var speed = 200
@export var friction = 1
@export var acceleration = 1

var facingRight: bool = true
var attacking: bool = false
var weaponInUse: int = 0
var hurting: bool = false
var gameOver:bool = false

func get_input():
	var input = Vector2()
	if Input.is_action_pressed("right") and attacking == false and gameOver == false:
		input.x += 1
		$PlayerBody.flip_h = false
		$PlayerBody/hair/hair1.flip_h = false
		$PlayerBody/hair/hair2.flip_h = false
		$PlayerBody/hair/hair3.flip_h = false
		$PlayerBody/weapon.flip_h = false
		facingRight = true
		
	if Input.is_action_pressed("left") and attacking == false and gameOver == false:
		input.x -= 1
		$PlayerBody.flip_h = true
		$PlayerBody/hair/hair1.flip_h = true
		$PlayerBody/hair/hair2.flip_h = true
		$PlayerBody/hair/hair3.flip_h = true
		$PlayerBody/weapon.flip_h = true
		facingRight = false
	if Input.is_action_pressed("down") and attacking == false and gameOver == false:
		input.y +=1
	
	if Input.is_action_pressed("up") and attacking == false and gameOver == false:
		input.y -=1
	
	if Input.is_action_pressed("1") and gameOver == false:
		weaponInUse = 0
		Global.weaponInUse = 0
	
	if Input.is_action_pressed("2") and gameOver == false:
		weaponInUse = 1
		Global.weaponInUse = 1
	
	return input
	
func _physics_process(delta: float) -> void:
	#health check
	if Global.health <= 0:
		$PlayerBody.modulate = Color("#ff0000")
		velocity = velocity.lerp(Vector2.ZERO, friction)
		$AnimationPlayer.stop()
		$Area2D/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
		gameOver = true
		
	#char chosen ifs
	if Global.charChosen == 1:
		$PlayerBody/hair/hair1.visible = true
		$PlayerBody/hair/hair2.visible = false
		$PlayerBody/hair/hair3.visible = false
		if weaponInUse == 0: # se le setea el arma
			$PlayerBody/weapon.frame_coords = Vector2(42,47)
		else:
			$PlayerBody/weapon.frame_coords = Vector2(41,48)
	elif Global.charChosen == 2:
		$PlayerBody/hair/hair1.visible = false
		$PlayerBody/hair/hair2.visible = true
		$PlayerBody/hair/hair3.visible = false
		if weaponInUse == 0:
			$PlayerBody/weapon.frame_coords = Vector2(42,47)
		else: 
			$PlayerBody/weapon.frame_coords = Vector2(41,48)
	elif Global.charChosen ==3 :
		$PlayerBody/hair/hair1.visible = false
		$PlayerBody/hair/hair2.visible = false
		$PlayerBody/hair/hair3.visible = true
		if weaponInUse == 0:
			$PlayerBody/weapon.frame_coords = Vector2(42,47)
		else: 
			$PlayerBody/weapon.frame_coords = Vector2(41,48)
			
	#player movement
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO,friction)
		
	#attacking logic
	if attacking == true:
		$PlayerBody/weapon.visible = true
	else:
		$PlayerBody/weapon.visible = false
		
	if Input.is_action_pressed("attacking") and gameOver == false:
		attacking = true
		if facingRight == true:
			if weaponInUse == 0:
				$PlayerBody/weapon/Area2DWeaponR/CollisionShape2D.disabled = false
				$PlayerBody/weapon/Area2DWeaponL/CollisionShape2D.disabled = true
			else: 
				$PlayerBody/weapon/Area2DPickL/CollisionShape2D.disabled = true
				$PlayerBody/weapon/Area2DPickR/CollisionShape2D.disabled = false
			$AnimationPlayer.play("swingR")
			await  $AnimationPlayer.animation_finished
		else: 
			if weaponInUse == 0:
				$PlayerBody/weapon/Area2DWeaponR/CollisionShape2D.disabled = true
				$PlayerBody/weapon/Area2DWeaponL/CollisionShape2D.disabled = false
			else: 
				$PlayerBody/weapon/Area2DPickL/CollisionShape2D.disabled = false
				$PlayerBody/weapon/Area2DPickR/CollisionShape2D.disabled = true
			$AnimationPlayer.play("swingL")
			await  $AnimationPlayer.animation_finished
		attacking = false
		$PlayerBody/weapon/Area2DWeaponR/CollisionShape2D.disabled = true
		$PlayerBody/weapon/Area2DWeaponL/CollisionShape2D.disabled = true
		$PlayerBody/weapon/Area2DPickL/CollisionShape2D.disabled = true
		$PlayerBody/weapon/Area2DPickR/CollisionShape2D.disabled = true
	if attacking == false:
		if velocity == Vector2(0,0):
			$AnimationPlayer.play("idle")
		else: 
			$AnimationPlayer.play("walking")
	
	move_and_slide()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") && hurting == false:
		hurting = true
		Global.health -= 1
		$PlayerBody.modulate = Color("#ff2d57")
		$Timer.start()


func _on_timer_timeout() -> void:
	$PlayerBody.modulate = Color("#ffffff")
	hurting = false
	$Area2D/CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = false

	
	
	
	
	
