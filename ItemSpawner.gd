extends Node2D

signal spawned()

export(PackedScene) var item_scene
export var max_spawn = 5 # max allowed spawned at a time
var spawn_count = 0

var items_left = 15 # num of items to spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset():
	items_left = 15
	spawn_count = 0
	for n in get_tree().get_root().get_children():
		if n is Item:
			get_tree().get_root().remove_child(n)
			n.queue_free()
		
func _on_Timer_timeout():
	# Create a new instance of the Mob scene.
	if spawn_count >= max_spawn or items_left <= 0:
		return
	
	spawn_count += 1
	items_left -= 1
	
	var mob = item_scene.instance()

	# Set the mob's position to spawner location.
	mob.position.x = position.x + rand_range(-32, 32);
	mob.position.y = position.y + rand_range(-32, 32);
	
	
	# Spawn the mob by adding it to the Main scene.
	get_tree().get_root().add_child(mob)
	emit_signal("spawned")


func _on_Player_collected(points):
	if points > 0:
		spawn_count -= 1
