extends StaticBody2D
class_name Brick

@onready var color_rect: ColorRect = get_node("Color")

func _ready() -> void:
	var random_color: int = randi_range(0, 10)
	if random_color == 0:
		color_rect.color = Color.DARK_RED
	elif random_color == 1:
		color_rect.color = Color.BLUE_VIOLET
	elif random_color == 2:
		color_rect.color = Color.SEA_GREEN
	elif random_color == 3:
		color_rect.color = Color.BISQUE
	elif random_color == 4:
		color_rect.color = Color.WHITE_SMOKE
	elif random_color == 5:
		color_rect.color = Color.BLANCHED_ALMOND
	elif random_color == 6:
		color_rect.color = Color.PURPLE
	elif random_color == 7:
		color_rect.color = Color.SKY_BLUE
	elif random_color == 8:
		color_rect.color = Color.AZURE
	elif random_color == 9:
		color_rect.color = Color.CYAN
	else: 
		color_rect.color = Color.TOMATO

var health_point: int = 1

func deal_damage():
	health_point -= 1
	if health_point < 1:
		queue_free()