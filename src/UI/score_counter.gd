extends Control
class_name ScoreCounter

@onready var label: Label = get_node("Label")
@export var highscore: Label

func _on_score_change(score: int) -> void:
	label.text = "SCORE: " + str(score)

func _on_highscore_change(score: int) -> void:
	highscore.text = "HIGHSCORE: " + str(score)
