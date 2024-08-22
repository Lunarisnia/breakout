extends CharacterBody2D
class_name Player

const PADDLE_SPEED = 300.0

var allowed_to_move: bool = false

func start(p_position: Vector2) -> void:
    global_position = p_position

func _physics_process(delta: float) -> void:
    var direction: Vector2 = Vector2.RIGHT * Input.get_axis("move_left", "move_right")

    velocity = direction * PADDLE_SPEED * delta

    move_and_collide(velocity)

func _on_game_over(paddle_start: Vector2) -> void:
    start(paddle_start)

func _on_game_manager_respawn(paddle_start:Vector2) -> void:
    start(paddle_start)
