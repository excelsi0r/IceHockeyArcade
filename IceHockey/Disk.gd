extends KinematicBody2D

const INIT_SPEED = 2
const MAX_SPEED = 6
var curr_speed

var velocity = Vector2()
var init_pos = Vector2()

var put1
var put2
var hit

var root

func _ready():
	init_pos = global_position
	root = get_tree().get_root().get_node("IceHockey")
	reset()
	put1 = get_tree().get_root().get_node("IceHockey/audio/put1")
	put2 = get_tree().get_root().get_node("IceHockey/audio/put2")
	hit = get_tree().get_root().get_node("IceHockey/audio/hit")
	pass
	
func reset():
	global_position = init_pos
	var angle = rand_range(0, PI * 2)
	velocity = calculate_velocity(angle, INIT_SPEED)
	curr_speed = INIT_SPEED
	pass
	
func _process(delta):
	
	if !root.playing:
		return
	
	if curr_speed > INIT_SPEED:
		curr_speed -= 5*delta
	
	var collision = move_and_collide(velocity)
	
	var colObject
	var colParent
	if collision != null:
		colObject = collision.collider
		colParent = collision.collider.get_parent()
	
	if colObject != null && colObject.name == "StickMan" && colParent.moving:
		playPut()
		curr_speed = MAX_SPEED
		if collision.collider.has_method("hit"):
			collision.collider.hit(1)
	elif colObject != null:
		hit.play()
		
	
	if collision:
		velocity = velocity.bounce(collision.normal)
		
	velocity = calculate_velocity(velocity.angle(), curr_speed)
	pass
	
func calculate_velocity(angle, speed):
	var x = speed * cos(angle)
	var y = speed * sin(angle)
	return Vector2(x, y)
	

func playPut():
	var value = rand_range(0, 1)
	if value <= 0.5:
		put1.play()
	elif value > 0.5: 
		put2.play()
	pass