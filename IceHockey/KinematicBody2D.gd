extends KinematicBody2D

var curr
const INCREMENT = 50
const MAX_UP = -INCREMENT
const MAX_DN = INCREMENT

func _ready():
	curr = 0
	pass

func _process(delta):
	
	if Input.is_action_pressed("ui_up") && curr >= MAX_UP:
		move_local_y(-1)
		curr -= 1
	elif Input.is_action_pressed("ui_down") && curr <= MAX_DN:
		move_local_y(1)
		curr += 1

	pass

func hit(sec):
	$Stick.disabled = true
	yield(get_tree().create_timer(sec), "timeout")
	$Stick.disabled = false
	pass