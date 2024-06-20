extends CharacterBody2D

@onready var http_request = $HTTPRequest

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health: int = 100
var sympathy: int = 0
var pnjName: String = "Alicia"
var talk: String = ""
var url: String = "https://meowfacts.herokuapp.com/"

func exchange_toLLM():
	#http_request.request(url)
	pass
	
#func _on_http_request_request_completed(result, response_code, headers, body):
	#var json = JSON.parse_string(body.get_string_from_utf8())
	#print(json["data"]) 

func get_sympaty():
	return sympathy

func get_npc_context():
	return get_meta("pnj_name")

func get_npc_name():
	return get_meta("pnj_name")

func get_talk():
	if get_meta("talk"):
		return get_meta("talk")
	else:
		return "res://main.dialogue"

# Méthode pour retourner les points de vie
func get_health() -> int:
	return health

func get_pnjname() -> String:
	return pnjName

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()

