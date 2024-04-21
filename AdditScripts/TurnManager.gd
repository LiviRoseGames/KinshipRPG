extends Resource
class_name TurnManager

enum {ALLY_TURN, ENEMY_TURN}

var turn := ALLY_TURN: 
	set = set_turn

signal  ally_TurnStarted()
signal  ally_TurnEnded()
signal  enemy_TurnStarted()

func set_turn(value : int) -> void:
	turn = value
	match turn:
		ALLY_TURN:
			emit_signal("ally_TurnStarted")
		ENEMY_TURN:
			emit_signal("ally_TurnEnded")
			emit_signal("enemy_TurnStarted")

func start() -> void:
	self.turn = ALLY_TURN

func advance_turn() -> void:
	self.turn = int(self.turn+1)&1
