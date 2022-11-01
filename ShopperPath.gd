extends Path2D

var inc = 0
export var speed = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inc += delta * speed
	$PathLocation.offset = inc
	

# Called when the node enters the scene tree for the first time.
func _ready():
	var paths = ['res://Paths/ShopperPath1.tres', 'res://Paths/ShopperPath2.tres', 'res://Paths/ShopperPath3.tres']
	curve = load(paths[randi() % paths.size()])

func spawn_child(child):
	$PathLocation.add_child(child)
