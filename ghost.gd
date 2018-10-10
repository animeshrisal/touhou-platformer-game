extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$alpha_tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0.5), Color(1,1,1,0), .2, Tween.TRANS_SINE, Tween.EASE_OUT)
	$alpha_tween.start()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_alpha_tween_tween_completed(object, key):
	queue_free()
