extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -400.0

var canTalk = false
var talkRessource = ""

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
	if canTalk == true :
		if Input.is_action_just_pressed("ui_accept") :
			print("ui accepted")
			#var resource = load("res://main.dialogue")
			var resource = load(talkRessource)
			print('ressource passed')
			var dialogue_line = await DialogueManager.show_dialogue_balloon(resource, "start")
			print('return')
			return


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(direction_x, direction_y).normalized() * SPEED
	shedule_animation(direction_x, direction_y)
	
	move_and_slide()


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("pnj"):
		if body.has_method("get_pnjname"):  # Vérifie si le body a une méthode pour obtenir les points de vie
			var health = body.get_pnjname()
			talkRessource = body.get_talk()  # Appelle la méthode pour obtenir les points de vie
			print("Le PNJ ", health, " est entré dans la zone avec ", State.statusDiscussion)
			canTalk = true


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("pnj"):
		if body.has_method("get_pnjname"):  # Vérifie si le body a une méthode pour obtenir les points de vie
			canTalk = false
			talkRessource = ""
			

