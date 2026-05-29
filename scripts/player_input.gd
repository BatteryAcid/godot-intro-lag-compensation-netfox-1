class_name PlayerInput
extends Node

signal weapon_fired

var input_dir: Vector2

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	NetworkTime.before_tick_loop.connect(_gather)

func _gather() -> void:
	if not is_multiplayer_authority():
		return
	
	if get_tree().get_multiplayer().has_multiplayer_peer() and not MatchManager.game_paused:
		input_dir = Input.get_vector("left", "right", "up", "down")
		
		if Input.is_action_just_pressed("fire"):
			weapon_fired.emit()
