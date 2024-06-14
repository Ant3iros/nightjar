extends CharacterBody2D


const SPEED = 40.0
@export var target: Node2D
@onready var navigation_agent = $NavigationAgent2D

func _physics_process(delta):
	var direction = Vector2.RIGHT
	direction = to_local(navigation_agent.get_next_path_position())
	direction = direction.normalized()
	velocity = direction * SPEED

	move_and_slide()

func _ready():
	navigation_agent.target_position = target.position


func _on_timer_timeout():
	navigation_agent.target_position = target.position

