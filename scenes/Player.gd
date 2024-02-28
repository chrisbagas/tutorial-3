extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200
export (int) var jump_speed = -600
export (int) var dash_speed = 900

const UP = Vector2(0,-1)
const DOUBLETAP_DELAY = .1

var velocity = Vector2()
var double_jump = false

var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0

func _process(delta):
	doubletap_time -= delta

func get_input():
	
	if is_on_floor() and Input.is_action_just_pressed('ui_up'):
		velocity.y = jump_speed
		double_jump = true
	if !is_on_floor() and double_jump and Input.is_action_just_pressed("ui_up"): 
		velocity.y = jump_speed
		double_jump = false
	if Input.is_action_pressed('ui_right'):
		velocity.x += speed
	if Input.is_action_pressed('ui_left'):
		velocity.x -= speed

	
func _input(event):
	if event is InputEventKey and event.is_pressed():
		doubletap_time = DOUBLETAP_DELAY
		if last_keycode == event.physical_scancode and doubletap_time >= 0: 
			print('DoubleTap')
			if Input.is_action_pressed('ui_right'):
				velocity.x = dash_speed
			if Input.is_action_pressed('ui_left'):
				velocity.x = -dash_speed
			last_keycode = 0
		else:
			last_keycode = event.physical_scancode

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
