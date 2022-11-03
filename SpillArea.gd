extends Area2D
class_name SpillArea

signal entered_spill(area)
signal cleaned_up()

var scale_factor = 1
var original_scale = Vector2.ONE

# Called when the node enters the scene tree for the first time.
func _ready():
	original_scale = $Sprite.scale
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpillArea_area_entered(area):
	if area is Broom:
		scale_factor -= rand_range(0.1, 0.2) 
		if scale_factor <= 0.1:
			queue_free()
			emit_signal("cleaned_up")
		else:
			update_scale()
	else:
		emit_signal("entered_spill", area)

func update_scale():
	$Sprite.scale.x = original_scale.x * scale_factor
	$Sprite.scale.y = original_scale.y * scale_factor
