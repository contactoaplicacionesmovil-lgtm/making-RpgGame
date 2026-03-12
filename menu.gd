extends Node2D

func _process(delta: float) -> void:
	if Global.lPoints == 0:
		#$AttackButtonUp/ButtonAttackUp.theme = null
		$AttackButtonUp/ButtonAttackUp.disabled = true
	else:
		#$AttackButtonUp/ButtonAttackUp.theme = null
		$AttackButtonUp/ButtonAttackUp.disabled = false
