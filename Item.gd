extends Interactable
class_name Item

var category = ""
var points = 25

var items = {
	'chicken' : { 'path': 'res://art/chicken.png', 'category': 'Meats'},
	'beer': { 'path': 'res://art/beer.png', 'category': 'Beer'},
	'beercan': { 'path': 'res://art/beercan1.png', 'category': 'Beer'},
	'soda': { 'path': 'res://art/beercan2.png', 'category': 'Drinks'},
	'soup': { 'path': 'res://art/beercan3.png', 'category': 'Cans'},
}

var item_names = items.keys()

# Called when the node enters the scene tree for the first time.
func _ready():
	offset_x = 36
	offset_y = -8
	
	var i = items[item_names[randi() % item_names.size()]]
	$Sprite.texture = load(i['path'])
	category = i['category']


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
