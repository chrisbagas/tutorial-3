extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200
export (int) var jump_speed = -600
export (int) var dash_speed = 900
onready var sprite = $Sprite

const UP = Vector2(0,-1)
const DOUBLETAP_DELAY = .1

var velocity = Vector2()
var double_jump = false

var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0
var is_dashing = false

func _process(delta):
	doubletap_time -= delta

func get_input():
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed('ui_up'):
		velocity.y = jump_speed
		double_jump = true
	if !is_on_floor() and double_jump and Input.is_action_just_pressed("ui_up"): 
		velocity.y = jump_speed
		double_jump = false
	if Input.is_action_pressed('ui_right'):
		sprite.flip_h = false
		if is_dashing:
			velocity.x += dash_speed
		else:
			velocity.x += speed
	if Input.is_action_pressed('ui_left'):
		sprite.flip_h = true
		if is_dashing:
			velocity.x -= dash_speed
		else:
			velocity.x -= speed
	if Input.is_action_pressed("crouch"):
		$Crouching.disabled = false
		$Normal.disabled = true
		
		sprite.position.x = 0
		sprite.position.y = 18.5
		sprite.scale.x = 1
		sprite.scale.y = 0.664
		
		speed = 200
		dash_speed = 0
		jump_speed = 0
	else:
		$Crouching.disabled = false
		$Normal.disabled = true
		
		sprite.position.x = 0
		sprite.position.y = 0
		sprite.scale.x = 1
		sprite.scale.y = 1
		
		speed = 400
		jump_speed = -600
		dash_speed = 900
	
func _input(event):
	if event is InputEventKey and event.is_pressed():
		doubletap_time = DOUBLETAP_DELAY
		if last_keycode == event.physical_scancode and doubletap_time >= 0: 
			print('DoubleTap')
			is_dashing = true
			last_keycode = 0
		else:
			is_dashing = false
			last_keycode = event.physical_scancode


func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
