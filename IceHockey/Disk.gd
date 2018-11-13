extends KinematicBody2D

var INIT_SPEED = 10
var velocity = Vector2()

func _ready():
	velocity = Vector2(rand_range(-INIT_SPEED/2, -INIT_SPEED), rand_range(0, INIT_SPEED/2))
	pass
	
func _process(delta):
	var collision = move_and_collide( velocity )
	
	if collision:
		velocity = velocity.bounce(collision.normal)
	pass