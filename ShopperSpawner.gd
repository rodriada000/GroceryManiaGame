extends Node2D

export(PackedScene) var shopper_scene
export(PackedScene) var path_scene

export var min_delay = 3
export var max_delay = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.wait_time = rand_range(min_delay, max_delay)

func reset():
	for n in get_children():
		if n != $SpawnTimer:
			remove_child(n)
			n.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpawnTimer_timeout():
	$SpawnTimer.wait_time = rand_range(min_delay, max_delay)
	var path = path_scene.instance()
	add_child(path)
	path.spawn_child(shopper_scene.instance())
