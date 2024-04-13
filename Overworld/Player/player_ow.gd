extends CharacterBody2D

const WALK_SPEED = 60

var lastDirection = "Right"

@onready var animationPlayer = $AnimationPlayer

func _ready() -> void:
	velocity = Vector2.ZERO
	animate_idle(lastDirection)

func _process(delta : float) -> void:
#Get player movement input
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * WALK_SPEED
	
	
#Move
	move_and_slide()
	
	if is_moving():
		animate_walk(input_vector)
	else:
		animate_idle(lastDirection)

func is_moving() -> bool:
	return velocity != Vector2.ZERO

func animate_walk(direction) -> void:
	if direction.x < 0:
		animationPlayer.play("WalkLeft")
		lastDirection = "Left"
	elif direction.x > 0:
		animationPlayer.play("WalkRight")
		lastDirection = "Right"
#For use cases when you are going straight up and down
	elif direction.x == 0 and is_moving():
		if lastDirection == "Right":
			animationPlayer.play("WalkRight")
		elif lastDirection == "Left":
			animationPlayer.play("WalkLeft")
	else:
		return

func animate_idle(direction) -> void:
	if direction == "Left":
		animationPlayer.play("IdleLeft")
	elif direction == "Right":
		animationPlayer.play("IdleRight")
	else:
		return
