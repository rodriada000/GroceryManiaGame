extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var multiplier = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$HUD.update_score(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_collected(points):
	if multiplier > 0:
		points = points * multiplier
	score += points
	
	if points < 0:
		multiplier = 0
	else:
		multiplier += 1
		multiplier = min(multiplier, 4)
		
	$HUD.update_score(score)
	$HUD.update_multiplier(multiplier)
