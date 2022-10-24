extends KinematicBody2D
class_name Shelf

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var category = "Drinks"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = category


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
