extends KinematicBody2D

signal hit()
signal collected(points)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 100
var screen_size
var holding_item = false
var has_broom = false
var item_ref = null
var item_held = null
var velocity = Vector2()
var is_stunned = false
var can_be_stun = true

var wrap_offset = 48

func _input(event):
	if event.is_action_pressed("pickup") and !is_stunned:
		pickup_or_drop_item()

func pickup_or_drop_item():
	if !holding_item:
		pickup_item()
	else:
		drop_item()


func pickup_item():
	if holding_item: return
	
	var touching_areas = $InteractArea.get_overlapping_areas()
	for i in touching_areas:
		if i is Interactable and i.can_pickup:
			item_held = i
			holding_item = true
			i.can_pickup = false
			has_broom = item_held is Broom
			return

func drop_item():
	if !holding_item: return
	
	holding_item = false
	has_broom = false
	
	if item_held is Item:
		var touching_areas = $InteractArea.get_overlapping_areas()
		for a in touching_areas:
			if a.is_in_group("ShelfRange"):
				if a.get_parent().category == item_held.category:
					emit_signal("collected", item_held.points)
					item_held.queue_free()
					item_held = null
					return
				else:
					# wrong shelf, lose points
					emit_signal("collected", -10)
					break
	
	item_held.can_pickup = true
	# adjust item to be in view port if dropped out side
	var item_size = item_held.get_size()
	item_held.position.x = clamp(item_held.position.x, item_size.x / 2, screen_size.x - (item_size.x / 2))
	item_held.position.y = clamp(item_held.position.y, item_size.y / 2, screen_size.y - (item_size.y / 2))
	item_held = null

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.animation = "idle"


func _process(delta):

		
	velocity = Vector2.ZERO # The player's movement vector.
	
	if !is_stunned:
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
		
	move_player(delta)
		
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0
	
	# move position of object held
	if item_held != null:
		var offset_x = item_held.offset_x * -1 if $AnimatedSprite.flip_h else item_held.offset_x
		item_held.position.x = position.x + offset_x
		item_held.position.y = position.y + item_held.offset_y

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2(0, -1))
	var colly = get_last_slide_collision()
	if colly != null and colly.collider.is_in_group('Shopper'):
		# lose life because of collision
		drop_item()
		hide() # Player disappears after being hit.
		emit_signal("hit")
	
func start(pos):
	position = pos
	is_stunned = false
	show()


func move_player(delta):
	position += velocity * delta
	position.x = clamp(position.x, -1 * wrap_offset, screen_size.x + wrap_offset)
	position.y = clamp(position.y, -1 * wrap_offset, screen_size.y + wrap_offset)
	
	if position.x >= screen_size.x + wrap_offset:
		position.x = 0 - wrap_offset
	elif position.x <= 0 - wrap_offset:
		position.x = screen_size.x + wrap_offset
		
	if position.y >= screen_size.y + wrap_offset:
		position.y = 0 - wrap_offset
	elif position.y <= 0 - wrap_offset:
		position.y = screen_size.y + wrap_offset


func _on_SlipArea_area_entered(area):
	if area is SpillArea and !has_broom and can_be_stun:
		is_stunned = true
		can_be_stun = false
		$StunTimer.wait_time = rand_range(0.75, 1.25)
		$StunTimer.start()
		$Tween.interpolate_property($AnimatedSprite, "modulate:a", $AnimatedSprite.modulate.a, 0.4, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()

func _on_StunTimer_timeout():
	$StunSafeTimer.start()
	is_stunned = false


func _on_StunSafeTimer_timeout():
	can_be_stun = true
	$Tween.stop_all()
	$AnimatedSprite.modulate.a = 1
