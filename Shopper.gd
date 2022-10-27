extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sprites = ['res://art/customer1.png', 'res://art/customer2.png']

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = load(sprites[randi() % sprites.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
