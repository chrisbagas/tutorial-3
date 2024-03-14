extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -600
export (int) var GRAVITY = 1200

const UP = Vector2(0,-1)

var velocity = Vector2()
var arah = 'kanan'
func get_input():
	var animation = "Idle"
	
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed('ui_up'):
		velocity.y = jump_speed
	if !is_on_floor():
		animation = 'Loncat'
	if Input.is_action_pressed('ui_right'):
		velocity.x += speed
		if is_on_floor():
			animation = "Jalan"
		arah = 'kanan'
	if Input.is_action_pressed('ui_left'):
		velocity.x -= speed
		if is_on_floor():
			animation = 'Jalan'
		arah = 'kiri'

	if $AnimatedSprite.animation != animation:
		print(arah)
		if arah == 'kiri':
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		$AnimatedSprite.play(animation)

		

func _physics_process(delta):
  velocity.y += delta * GRAVITY
  get_input()
  velocity = move_and_slide(velocity, UP)
