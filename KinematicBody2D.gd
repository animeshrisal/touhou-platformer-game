extends KinematicBody2D

signal health_changed

var new_animation = ""
var current_animation = ""
var running = false
var shooting = false
var hitstun = 0
var position_difference = Vector2(0, 0)
const UP = Vector2(0, -1)
var GRAVITY = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = -400
const ACCELERATION = 20
var counter = 0
var motion = Vector2()
var knockdir = Vector2(0, 0)
const TYPE = "PLAYER"
export var max_health = 10
var health = max_health



func _physics_process(delta):
	
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("shoot"):
		shooting = true
	elif Input.is_action_just_released("shoot"):
		counter = 0
		shooting = false
	
	if Input.is_action_pressed("ui_right"):
		new_animation = "walk"
		
		if Input.is_action_pressed("shoot"):
			new_animation = "walk_and_shoot"

		
		running = false
		$AnimatedSprite.flip_h = true
		
		if Input.is_action_pressed("run"):
			motion.x = min(motion.x + ACCELERATION, 400)
			running = true
		else:
			motion.x = min(motion.x + ACCELERATION, 200)
			running = false
			
	elif Input.is_action_pressed("ui_left"):
		new_animation = "walk"
		if Input.is_action_pressed("shoot"):
			new_animation = "walk_and_shoot"

		
		$AnimatedSprite.flip_h = false
		if Input.is_action_pressed("run"):
			motion.x = max(motion.x - ACCELERATION, -400)
			running = true
		else:
			motion.x = max(motion.x - ACCELERATION, -200)
			running = false
		
	else:
		new_animation = "stand"
		
		if shooting == true:
			new_animation = "shoot"
		friction = true
		

		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT

		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:

		if motion.y < 0:
			new_animation = "jump_up"
		else:
			new_animation = "jump_down"
			
		if shooting == true:
			new_animation = "jump_and_shoot"

		if friction == true:
			motion.x = lerp(motion.x, 0, 0.1)
		
	if shooting == true and counter == 0:
		counter = 1
		var bullet = preload("res://Scenes/Bullet.tscn").instance()
		get_parent().add_child(bullet);
		bullet.position = get_position()
		bullet.position.y += 4
		
		if $AnimatedSprite.flip_h == true:
			bullet.speed.x = 2
			bullet.position.x += 4
			bullet.set_scale(Vector2(-1, 1))
		
		else:
			bullet.position.x += -4
			
	if current_animation != new_animation:
		$AnimatedSprite.play(new_animation)
		
		
	if hitstun == 0:
		motion = move_and_slide(motion, UP)
	else:
		health -= 1
		hitstun = 0
		motion = move_and_slide(position_difference.normalized() * -250, UP)
		emit_signal("health_changed")
		
		if health <= 0:
			get_tree().change_scene("res://Main Menu.tscn")
			
	
		
	for body in $Area2D.get_overlapping_bodies():
		if body.get("TYPE") == "FAIRY":
			position_difference = body.global_position - global_position
			hitstun = 1
			
func _on_ghost_timer_timeout():
	if running == true:
		var this_ghost = preload("res://ghost.tscn").instance()
		get_parent().add_child(this_ghost);
		this_ghost.position = position
		this_ghost.texture = $AnimatedSprite.frames.get_frame($AnimatedSprite.animation, $AnimatedSprite.frame)
		this_ghost.flip_h = $AnimatedSprite.flip_h

func _on_Area2D_area_entered(area):
	if area.get("TYPE") == "FAIRY_BULLET":
		area.queue_free()
		hitstun = 1
		position_difference = area.global_position - global_position

	
	
