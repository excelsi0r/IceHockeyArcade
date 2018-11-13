extends Area2D

func _ready():
	connect("body_entered",self,"_on_Area2D_body_enter")
	pass
	
func _on_Area2D_body_enter( body ):
	if body.has_method("reset"): body.reset()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
