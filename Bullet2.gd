extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var speed = Vector2(-2, 0)

var BULLET_SPEED = 400
const TYPE = "FAIRY_BULLET"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var motion = speed * BULLET_SPEED
	position += motion * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # replace with function body
