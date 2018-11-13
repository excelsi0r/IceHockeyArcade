extends KinematicBody2D

const INIT_SPEED = 5
const MAX_SPEED = 10
var curr_speed

var velocity = Vector2()
var init_pos = Vector2()

func _ready():
	init_pos = global_position
	reset()
	pass
	
func reset():
	global_position = init_pos
	var angle = rand_range(0, PI * 2)
	velocity = calculate_velocity(angle, INIT_SPEED)
	curr_speed = INIT_SPEED
	pass
	
func _process(delta):
	
	if curr_speed > INIT_SPEED:
		curr_speed -= 5*delta
	
	var collision = move_and_collide(velocity)
	
	if collision != null && collision.collider.name == "Stick" && (Input.is_key_pressed(KEY_S) || Input.is_key_pressed(KEY_W) || Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_right")):
		curr_speed = MAX_SPEED
	
	if collision:
		velocity = velocity.bounce(collision.normal)
		
	velocity = calculate_velocity(velocity.angle(), curr_speed)
		
	pass
	
func calculate_velocity(angle, speed):
	var x = speed * cos(angle)
	var y = speed * sin(angle)
	return Vector2(x, y)
	

	