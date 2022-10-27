extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_multiplier(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func update_multiplier(m):
	if m <= 1:
		$MultiplierLabel.text = ""
	else:
		$MultiplierLabel.text = "x" + str(m)
