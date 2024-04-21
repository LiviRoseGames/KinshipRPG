extends CharacterBody2D

@export var data : GameData

const WALK_SPEED = 240

@onready var animationPlayer = $AnimationPlayer

var lastWalk = "IdleDown"

func _ready() -> void:
	global_position = data.globalPosPlayer
	animate_idle(data.directionPlayer)
	velocity = Vector2.ZERO

func _process(delta : float) -> void:
#Get player movement input
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * WALK_SPEED
	
	
#Move
	move_and_slide()
	
	if is_moving():
		animate_walk()
	else:
		animate_idle(animationPlayer.current_animation)

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		data.globalPosPlayer = global_position
		data.directionPlayer = lastWalk
		get_tree().change_scene_to_file("res://Battle/battle.tscn")

func is_moving() -> bool:
	return velocity != Vector2.ZERO

func animate_walk() -> void:
	var angle : float = velocity.angle()
	var angleDegrees : float = rad_to_deg(angle)
	var roundedAngle : int = int(round(angleDegrees / 45)*45)
	match roundedAngle:
		-90: animationPlayer.play("WalkUp")
		90: animationPlayer.play("WalkDown")
		0: animationPlayer.play("WalkRight")
		180: animationPlayer.play("WalkLeft")
		45: animationPlayer.play("WalkDownRight")
		135: animationPlayer.play("WalkDownLeft")
		-45: animationPlayer.play("WalkUpRight")
		-135: animationPlayer.play("WalkUpLeft")
	
	lastWalk = animationPlayer.current_animation

	
	
#Old Directional Code ---------------------------------------------------------------
	#if direction.x < 0:
		#animationPlayer.play("WalkLeft")
		#lastDirection = "Left"
	#elif direction.x > 0:
		#animationPlayer.play("WalkRight")
		#lastDirection = "Right"
##For use cases when you are going straight up and down
	#elif direction.x == 0 and is_moving():
		#if lastDirection == "Right":
			#animationPlayer.play("WalkRight")
		#elif lastDirection == "Left":
			#animationPlayer.play("WalkLeft")
	#else:
		#return

func animate_idle(direction) -> void:
	match direction:
		"WalkUp" : animationPlayer.play("IdleUp")
		"WalkDown" : animationPlayer.play("IdleDown")
		"WalkRight" : animationPlayer.play("IdleRight")
		"WalkLeft" : animationPlayer.play("IdleLeft")
		"WalkDownRight" : animationPlayer.play("IdleDownRight")
		"WalkDownLeft" : animationPlayer.play("IdleDownLeft")
		"WalkUpRight" : animationPlayer.play("IdleUpRight")
		"WalkUpLeft" : animationPlayer.play("IdleUpLeft")
		
		"IdleUp" : animationPlayer.play("IdleUp")
		"IdleDown" : animationPlayer.play("IdleDown")
		"IdleRight" : animationPlayer.play("IdleRight")
		"IdleLeft" : animationPlayer.play("IdleLeft")
		"IdleDownRight" : animationPlayer.play("IdleDownRight")
		"IdleDownLeft" : animationPlayer.play("IdleDownLeft")
		"IdleUpRight" : animationPlayer.play("IdleUpRight")
		"IdleUpLeft" : animationPlayer.play("IdleUpLeft")
		
	lastWalk = animationPlayer.current_animation
