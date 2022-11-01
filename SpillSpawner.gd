extends Node2D

export(PackedScene) var spill_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpillTimer_timeout():
	print('spawn spill')
	var spill = spill_scene.instance()
	var shelfs = get_tree().get_nodes_in_group('ShelfRange')
	var random_shelf = shelfs[randi() % shelfs.size()].get_owner()
	
	var offset_x = 0
	var offset_y = 0
	print(abs(floor(random_shelf.rotation_degrees)))
	print(floor(abs(random_shelf.rotation_degrees)))
	
	#calc offset based on rotation degrees (which way is shelf spinning)
	if abs(floor(random_shelf.rotation_degrees)) == 90 or abs(ceil(random_shelf.rotation_degrees)) == 90:
		offset_x = 64 if random_shelf.rotation_degrees > 0 else -64
	elif abs(floor(random_shelf.rotation_degrees)) == 180 or abs(ceil(random_shelf.rotation_degrees)) == 180:
		offset_y = -64 if random_shelf.rotation_degrees > 0 else 64
	
	spill.position.x = random_shelf.position.x + offset_x
	spill.position.y = random_shelf.position.y + offset_y
	get_tree().get_root().add_child(spill)
