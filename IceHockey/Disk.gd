extends KinematicBody2D

var INIT_SPEED = 5
var velocity = Vector2()
var INIT_POS = Vector2()

func _ready():
	velocity = Vector2(rand_range(-INIT_SPEED/2, -INIT_SPEED), rand_range(0, INIT_SPEED/2))
	INIT_POS = global_position
	
	pass
	
func _process(delta):
	var collision = move_and_collide( velocity )
	
	if collision:
		velocity = velocity.bounce(collision.normal)
	pass
	
func reset():
	global_position = INIT_POS
	velocity = Vector2(rand_range(-INIT_SPEED/2, -INIT_SPEED), rand_range(0, INIT_SPEED/2))
	pass
	