extends Control
class_name FPSCounter

@onready var label: Label = get_node("Label")

func _physics_process(_delta: float) -> void:
	label.text = "FPS: " + str(Engine.get_frames_per_second())
