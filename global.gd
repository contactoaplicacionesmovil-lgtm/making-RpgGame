extends Node

var charChosen: int = 0
var health: int = 3

var attack: int = 1
var miningStrength: int = 1
var charSpeed: int = 1

var xp: int = 0
var currentLevel: int = 0
var lPoints: int = 0
var weaponInUse: int =0

func _process(delta: float) -> void:
	if xp>= 10:
		currentLevel +=1
		lPoints +=1
		xp -= 10
