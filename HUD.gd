extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lives_path = 'res://art/life_icon.png'
var icons = []

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

func update_lives(lives):
	if (icons.size() > 0):
		for i in icons:
			remove_child(i)
		icons.clear()
	
	if lives > 0:
		for i in range(0, lives):
			var icon = Sprite.new()
			icon.texture = load(lives_path)
			icon.position = $LivesPosition.position
			icon.position.x += i * icon.texture.get_width() + 5
			icons.append(icon)
			add_child(icon)

func update_items(item_count):
	if item_count > 0:
		$ItemsLeftLabel.text = "Items Left: " + str(item_count)
	else:
		$ItemsLeftLabel.text = ""
