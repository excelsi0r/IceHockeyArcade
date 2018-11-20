extends Node2D

var ROT_MAX_W
var ROT_MAX_S
var INIT_ROT
var moving

var root
var disk

var entered

const CLOSE = 50

const SPEED = 5*PI #duas voltas por segundo

func _ready():
	ROT_MAX_W = rotation - PI
	ROT_MAX_S = rotation + PI
	INIT_ROT = rotation
	moving = false
	entered = false
	root = get_tree().get_root().get_node("IceHockey")
	disk = root.get_node("Game/Disk")
	pass

func _process(delta):
	
	if !root.playing:
		return
		
	
	var increment = SPEED*delta
	
	var incremented_rotation_w = rotation - increment
	var incremented_rotation_s = rotation + increment
	
	if root.rigthUp && incremented_rotation_w > ROT_MAX_W:
		rotate(-increment)
		moving = true
	elif root.rigthUp && incremented_rotation_w <= ROT_MAX_W:
		rotation = ROT_MAX_W
		moving = false
	elif !root.rigthUp && !root.rigthDown && rotation < INIT_ROT:
		if rotation + (increment) > INIT_ROT:
			rotation = INIT_ROT
			moving = false
		else:
			rotate(increment)
			moving = true
	elif root.rigthDown && incremented_rotation_s < ROT_MAX_S:
		rotate(increment)
		moving = true
	elif root.rigthDown && incremented_rotation_s >= ROT_MAX_S:
		rotation = ROT_MAX_S
		moving = false
	elif !root.rigthUp && !root.rigthDown && rotation > INIT_ROT:
		if rotation - (increment) < INIT_ROT:
			rotation = INIT_ROT
			moving = false
		else:
			rotate(-increment)
			moving = true
			
	if root.gametype != null && root.gametype == 2:
		if disk.position.distance_to(position) < CLOSE:
			entered = true
			if position.y < disk.position.y:
				root.rigthUp = false
				root.rigthDown = true
			elif position.y > disk.position.y:
				root.rigthUp = true
				root.rigthDown = false
				
	if entered && disk.position.distance_to(position) > CLOSE:
		entered = false
		root.rigthUp = false
		root.rigthDown = false

	pass
