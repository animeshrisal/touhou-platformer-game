extends Sprite

func _process(delta):
	pass

func _on_Area2D_area_entered(area):
	pass# replace with function body


func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		queue_free()
