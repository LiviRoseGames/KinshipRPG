extends Sprite2D
class_name BattleAnimations

@onready var animPlayer = $AnimationPlayer
@onready var sprite = $"."

signal animation_finished

func _ready() -> void:
	randomize()
	sprite.frame = randi_range(0, 8)
	animPlayer.animation_finished.connect(
		func (animation):
			animation_finished.emit()
)

func get_current_anim_length() -> float:
	return animPlayer.current_animation_length

func play(animation_name : String) -> void:
	assert(animPlayer.has_animation(animation_name))
	animPlayer.play(animation_name)
