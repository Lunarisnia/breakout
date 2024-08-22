extends Node2D
class_name BrickManager

signal brick_count(n: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brick_count.emit(get_child_count(true))