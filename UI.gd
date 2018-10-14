extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var health = $health
var player_health
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	player_health = $"../../KinematicBody2D".max_health
	health.text = str(player_health)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_KinematicBody2D_health_changed():
	player_health -= 1
	health.text = str(player_health)
