extends Node2D

var turnManager : TurnManager = ReferenceStash.turnManager

@onready var player_BattleUnit = $PlayerMark/PlayerBattleUnit
@onready var enemy_BattleUnit = $EnemyMark/EnemyBattleUnit
@onready var animationPlayer = $AnimationPlayer
@onready var timer = $Timer

func _ready() -> void:
	await animationPlayer.animation_finished
	turnManager.ally_TurnStarted.connect(_on_ally_turnStarted)
	turnManager.enemy_TurnStarted.connect(_on_enemy_turnStarted)
	turnManager.start()

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Overworld/Overworld.tscn")

func _on_ally_turnStarted() -> void:
	print("Ally turn")
	await player_BattleUnit.melee_attack(enemy_BattleUnit)
	#timer.start(1.0)
	#await timer.timeout
	turnManager.advance_turn()

func _on_enemy_turnStarted() -> void:
	print("Enemy turn")
	await enemy_BattleUnit.melee_attack(player_BattleUnit)
	#timer.start(1.0)
	#await timer.timeout
	turnManager.advance_turn()
