extends CharacterBody2D

var rockHealth: int = 2
var beingHit: bool = false

func _physics_process(delta: float) -> void:
	if rockHealth <= 0:
		Global.xp += 1
		queue_free()
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickaxe") and beingHit == false and Global.weaponInUse == 1:
		rockHealth -= Global.miningStrength
		beingHit = true
		$AnimationPlayer.play("hit")
		await $AnimationPlayer.animation_finished
		beingHit = false
		
