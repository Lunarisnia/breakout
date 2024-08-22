extends Control
class_name PauseMenu

signal game_paused(status: bool)
signal reset_game

@onready var overlay: ColorRect = get_node("Overlay")

func _on_button_pressed() -> void:
	game_paused.emit(true)
	overlay.show()

func _on_reset_pressed() -> void:
	game_paused.emit(false)
	overlay.hide()
	reset_game.emit()

func _on_back_to_game_pressed() -> void:
	game_paused.emit(false)
	overlay.hide()
