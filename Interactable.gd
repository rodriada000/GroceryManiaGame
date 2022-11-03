extends Area2D
class_name Interactable

export var can_pickup = true
var offset_x = 36
var offset_y = -8

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_size():
	var sz = Vector2.ZERO
	sz.x = $Sprite.texture.get_width()
	sz.y = $Sprite.texture.get_height()
	return sz

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

