extends KinematicBody2D

var curr
const INCREMENT = 50
const MAX_UP = -INCREMENT
const MAX_DN = INCREMENT
const mov_speed_inc = 2

var root

func _ready():
	curr = 0
	root = get_tree().get_root().get_node("IceHockey")
	pass

func _process(delta):
	
	if !root.playing:
		return
	
	if root.leftGoalUp && curr >= MAX_UP:
		move_local_y(-mov_speed_inc)
		curr -= mov_speed_inc
	elif root.leftGoalDown  && curr <= MAX_DN:
		move_local_y(mov_speed_inc)
		curr += mov_speed_inc

	pass

func hit(sec):
	$Stick.disabled = true
	yield(get_tree().create_timer(sec), "timeout")
	$Stick.disabled = false
	pass