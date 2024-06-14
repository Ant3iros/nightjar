extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func shedule_animation(x_direction, y_direction):
	match Vector2(x_direction, y_direction):
		Vector2.RIGHT: 
			$AnimatedSprite2D.play("walkRight")
			$AnimatedSprite2D.flip_h = false
		Vector2.LEFT: 
			$AnimatedSprite2D.play("walkRight")
			$AnimatedSprite2D.flip_h = true
		Vector2.DOWN: 
			$AnimatedSprite2D.play("walkBot")
		Vector2.UP: 
			$AnimatedSprite2D.play("walkTop")
		Vector2.ZERO: 
			$AnimatedSprite2D.stop()
		Vector2(1,1):
			$AnimatedSprite2D.play("walkRightBottom")
			$AnimatedSprite2D.flip_h = false
		Vector2(1,-1):
			$AnimatedSprite2D.play("walkRightTop")
			$AnimatedSprite2D.flip_h = false
		Vector2(-1,1):
			$AnimatedSprite2D.play("walkRightBottom")
			$AnimatedSprite2D.flip_h = true
		Vector2(-1,-1):
			$AnimatedSprite2D.play("walkRightTop")
			$AnimatedSprite2D.flip_h = true
	pass

func _physics_process(delta):
	# Add the gravity.

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(direction_x, direction_y).normalized() * SPEED
	shedule_animation(direction_x, direction_y)
	
	move_and_slide()
