extends Control
class_name LifeCounter

@onready var label: Label = get_node("Label")

func _on_life_change(life: int) -> void:
	label.text = "LIFE: " + str(life)

