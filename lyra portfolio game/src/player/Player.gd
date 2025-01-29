extends CharacterBody2D

@onready var anime = get_node("AnimatedSprite2D")

const speed = 300.0

func _ready():
	anime.play("down")

func _physics_process(_delta):
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_up",true):
		anime.play("up")
		velocity.y = -speed
	if Input.is_action_pressed("ui_down",true):
		anime.play("down")
		velocity.y = speed
	if Input.is_action_pressed("ui_left",true):
		anime.play("left")
		velocity.x = -speed
	if Input.is_action_pressed("ui_right",true):
		anime.play("right")
		velocity.x = speed
	if velocity.length() > 0:
		move_and_slide()
	pass	
