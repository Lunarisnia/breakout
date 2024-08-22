extends CharacterBody2D
class_name Ball

signal exit_position(position: Vector2)
signal brick_destroyed
signal play_audio(audio: AudioStream, shift_pitch: bool)

@onready var collision_audio: AudioStream = preload("res://assets/Audio/collision.wav")
@onready var notifier: VisibleOnScreenNotifier2D = get_node("VisibleOnScreenNotifier2D")

@export var player: Player

const STARTING_SPEED = 400.0
var speed: float = 400.0
var diagonal_speed: float = 150.0
var speed_increment: float = 15.0

var magnetic: bool = true

func start(p_position: Vector2) -> void:
	velocity = Vector2.ZERO
	global_position = p_position

func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("start") && magnetic:
		magnetic = false
		var direction: Vector2 = Vector2(0, -1)
		if direction.y == 0.0:
			direction.y = -1
		direction = direction.normalized()
		velocity = direction * speed

func _physics_process(delta: float) -> void:
	if magnetic:
		global_position = player.global_position + Vector2.UP * 30.0
	else:
		var collision: KinematicCollision2D = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			velocity = (velocity.normalized() * speed + collision.get_collider_velocity().normalized() * diagonal_speed).normalized() * speed
			play_audio.emit(collision_audio, true)
			if collision.get_collider() as Brick:
				collision.get_collider().call("deal_damage")
				brick_destroyed.emit()
				speed += speed_increment

func _on_exited() -> void:
	exit_position.emit(global_position)
	velocity = Vector2.ZERO

func _on_game_over(_paddle_start: Vector2) -> void:
	magnetic = true
	start(player.global_position + Vector2.UP * 30.0)
	speed = STARTING_SPEED

func _on_start_game() -> void:
	start(player.global_position + Vector2.UP * 30.0)

func _on_game_manager_respawn(_paddle_start:Vector2) -> void:
	magnetic = true
	start(player.global_position + Vector2.UP * 30.0)
