extends Node2D

export(PackedScene) var item_scene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_spawn = 5
var spawn_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	# Create a new instance of the Mob scene.
	if spawn_count >= max_spawn:
		return
	
	spawn_count += 1
	
	var mob = item_scene.instance()

	# Set the mob's position to spawner location.
	mob.position.x = position.x + rand_range(-32, 32);
	mob.position.y = position.y + rand_range(-32, 32);
	
	
	# Spawn the mob by adding it to the Main scene.
	get_tree().get_root().add_child(mob)


func _on_Player_collected(points):
	if points > 0:
		spawn_count -= 1
