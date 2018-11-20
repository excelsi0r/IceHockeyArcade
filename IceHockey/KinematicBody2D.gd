extends KinematicBody2D

var curr
const INCREMENT = 50
const MAX_UP = -INCREMENT
const MAX_DN = INCREMENT
const mov_speed_inc = 2


var disk
var root

func _ready():
	curr = 0
	root = get_tree().get_root().get_node("IceHockey")
	disk = root.get_node("Game/Disk")
	pass

func _process(delta):
	
	if !root.playing:
		return
	
	if root.rigthGoalUp && curr >= MAX_UP:
		move_local_y(-mov_speed_inc)
		curr -= mov_speed_inc
	elif root.rigthGoalDown  && curr <= MAX_DN:
		move_local_y(mov_speed_inc)
		curr += mov_speed_inc

	if root.gametype != null && root.gametype == 2:
		if disk.position.distance_to(get_parent().position) < 200:
			if get_parent().position.y < disk.position.y:
				root.rigthGoalUp = false
				root.rigthGoalDown = true
			elif get_parent().position.y > disk.position.y:
				root.rigthGoalUp = true
				root.rigthGoalDown = false
			else: 
				root.rigthGoalUp = false
				root.rigthGoalDown = false
			
	pass

func hit(sec):
	$Stick.disabled = true
	yield(get_tree().create_timer(sec), "timeout")
	$Stick.disabled = false
	pass