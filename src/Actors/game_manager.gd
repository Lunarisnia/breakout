extends Node2D
class_name GameManager

signal start_game
signal respawn(paddle_start: Vector2)
signal game_over(paddle_start: Vector2)
signal score_change(score: int)
signal life_change(life: int)
signal highscore_change(score: int)

@export var paddle_start: Marker2D
@export var stages: Array[PackedScene]

var player_score: int = 0
var high_score: int = 0
var player_life: int = 3
var brick_on_stage_count: int = 0
var current_stage: int = 0
var active_stage: BrickManager

func _load_score():
	if !FileAccess.file_exists("user://highscore.save"):
		return

	var save_file: FileAccess = FileAccess.open("user://highscore.save", FileAccess.READ)
	var line: String = save_file.get_line()
	print(line, "=====")
	high_score = int(line)
	save_file.close()

func _save_highscore():
	var save_file: FileAccess = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	save_file.store_line(str(high_score))
	save_file.close()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game.emit()
	_spawn_stage()
	_load_score()
	highscore_change.emit(high_score)

func _spawn_stage():
	if is_instance_valid(active_stage):
		active_stage.queue_free()
	current_stage = current_stage % len(stages)
	var stage: BrickManager = stages[current_stage].instantiate() as BrickManager
	stage.brick_count.connect(_on_brick_count)
	add_child(stage)
	active_stage = stage

func _on_brick_destroyed():
	brick_on_stage_count -= 1
	_update_score(player_score+1)
	if brick_on_stage_count < 1:
		print("You Won")
		game_over.emit(paddle_start.global_position)
		current_stage += 1
		_spawn_stage()

func _on_ball_exit_position(_position:Vector2) -> void:
	_update_life(player_life - 1)
	if player_life < 1:
		if player_score > high_score:
			high_score = player_score
			highscore_change.emit(high_score)
			_save_highscore()
		game_over.emit(paddle_start.global_position)
		current_stage = 0
		_update_life(3)
		_spawn_stage()
		_update_score(0)
	else:
		respawn.emit(paddle_start.global_position)

func _on_brick_count(n:int) -> void:
	brick_on_stage_count = n

func _update_score(n: int) -> void:
	player_score = n
	score_change.emit(player_score)

func _update_life(n: int) -> void:
	player_life = n
	life_change.emit(player_life)