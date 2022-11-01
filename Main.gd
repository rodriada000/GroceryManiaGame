extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var multiplier = 0
var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$HUD.update_score(score)
	$HUD.update_lives(lives)
	$HUD.update_items($ItemSpawner.items_left)
	new_game()


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

func new_game():
	score = 0
	lives = 3
	multiplier = 0
	$Player.start($StartPosition.position)

func _on_Player_hit():
	lives -= 1
	
	if lives < 0:
		pass # game over!
		
	print(lives)
	$HUD.update_lives(lives)
	$Player.start($StartPosition.position)


func _on_ItemSpawner_spawned():
	$HUD.update_items($ItemSpawner.items_left)
