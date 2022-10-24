extends KinematicBody2D

signal collected(points)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 100
var screen_size
var holding_item = false
var item_ref = null
var item_held = null
var velocity = Vector2()

func _input(event):
	if event.is_action_pressed("pickup"):
		pickup_or_drop_item()

func pickup_or_drop_item():
	if !holding_item:
		pickup_item()
	else:
		drop_item()


func pickup_item():
	if holding_item: return
	
	var touching_areas = $Area2D.get_overlapping_areas()
	for i in touching_areas:
		if i is Item and i.can_pickup:
			item_held = i
			holding_item = true
			i.can_pickup = false
			return

func drop_item():
	if !holding_item: return
	
	holding_item = false
	var touching_areas = $Area2D.get_overlapping_areas()
	for a in touching_areas:
		if a.is_in_group("ShelfRange") and a.get_parent().category == item_held.category:
			emit_signal("collected", item_held.points)
			item_held.queue_free()
			item_held = null
			return
	
	item_held.can_pickup = true
	item_held = null

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.animation = "idle"


func _process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.animation = "run" if !holding_item else "run_holding"
	else:
		$AnimatedSprite.animation = "idle" if !holding_item else "idle_holding"
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
		
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0
	
	# move position of object held
	if item_held != null:
		var offset_x = item_held.offset_x * -1 if $AnimatedSprite.flip_h else item_held.offset_x
		item_held.position.x = position.x + offset_x
		item_held.position.y = position.y + item_held.offset_y

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2(0, -1))

