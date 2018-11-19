extends Area2D

var root

func _ready():
	connect("body_entered",self,"_on_Area2D_body_enter")
	root = get_tree().get_root().get_node("IceHockey")
	pass
	
func _on_Area2D_body_enter( body ):
	if body.name == "Disk" && body.has_method("reset"):
		root.blueScore()
		body.reset()
		
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
