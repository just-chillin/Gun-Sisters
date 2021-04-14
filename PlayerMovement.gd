extends KinematicBody2D

export var gravity = 10000
export var speed = 200
export var jump_impulse = -2000


var velocity := Vector2.ZERO

#
# Movement Logic
#
func jump():
	velocity.y = jump_impulse
	$AnimatedSprite.play("jump")

func slide(_delta):
	velocity.x = speed * (Input.get_action_strength("right") - Input.get_action_strength("left"))
func move(delta):
	var prev_vel := velocity

	# Side-to-Side movement
	slide(delta)
	
	# Jumping and Gravity
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		jump()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Filter out idle from debug logs
	#if velocity != Vector2.ZERO || prev_vel != velocity:
	#	print_debug('player.velocity =', velocity)

#
# Animation logic
#
func animate(_delta):
	if velocity == Vector2.ZERO:
		$AnimatedSprite.play("idle")
	if velocity.y == 0:
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("walk", true)
		elif velocity.x > 0:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("walk", false)
		

func _physics_process(delta):
	move(delta)
	animate(delta)

