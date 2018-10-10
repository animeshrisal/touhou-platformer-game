extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var player = get_parent().get_node("KinematicBody2D")
var current_animation = ""
var new_animation = ""
var counter = 0
var y = 20
var motion = Vector2(0, y)
var UP = Vector2(0, -1)
const TYPE = "FAIRY"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	counter += 1
	if is_on_floor():
		counter = 0
		motion.y = -y
		
		
	if counter == 100:
		motion.y = y
		counter = 0

		
	new_animation = "fly"
	position += motion * delta
		
	if new_animation != current_animation:
		current_animation = new_animation
		$AnimationPlayer.play(current_animation)
		
	motion = move_and_slide(motion, UP)