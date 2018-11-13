extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
		
	pass

func hit(sec):
	print(get_parent().name)
	$Stick.disabled = true
	yield(get_tree().create_timer(sec), "timeout")
	$Stick.disabled = false
	pass