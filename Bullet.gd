extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed_x = -2
var speed_y = 0
	

const BULLET_SPEED = 400

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var motion = Vector2(speed_x, speed_y) * BULLET_SPEED
	position += motion * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Bullet_body_entered(body):
	if body.is_in_group("Fairies"):
		print("AAAA")
		queue_free()
		body.queue_free() # replace with function body
