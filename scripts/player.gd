class_name Player
extends Node2D

const SPEED = 600.0
const JUMP_VELOCITY = -400.0
const ship_types: Array[String] = ["default", "ship2"]

@export var player_input: PlayerInput
@export var player_sprite: AnimatedSprite2D
@export var selected_ship: String = ship_types[0]
@export var attribute_component: AttributeComponent
@export var health_bar: TextureProgressBar

var _health_colors = [Color.RED, Color.ORANGE_RED, Color.YELLOW, Color.GREEN_YELLOW, Color.LIME_GREEN]
var _velocity: Vector2

func _enter_tree() -> void:
	player_input.set_multiplayer_authority(str(name).to_int())

func _ready() -> void:
	set_physics_process(false)
	player_sprite.animation = selected_ship
	
	attribute_component.health_changed.connect(_health_changed)
	
	if is_multiplayer_authority():
		attribute_component.no_health.connect(_player_no_health)
		MatchManager.game_restarted.connect(reset_player)
	
func _rollback_tick(delta: float, tick: int, is_fresh: bool) -> void:
	if get_tree().get_multiplayer().has_multiplayer_peer() and not MatchManager.game_paused:
		var direction := player_input.input_dir
		if direction:
			_velocity.x = direction.x * SPEED
			_velocity.y = direction.y * SPEED
		else:
			_velocity.x = move_toward(_velocity.x, 0, SPEED)
			_velocity.y = move_toward(_velocity.y, 0, SPEED)

		translate(_velocity * delta)

func _health_changed():
	health_bar.value = attribute_component.health

	if attribute_component.health > 0:
		var texture = health_bar.texture_progress
		texture.gradient.colors[0] = _health_colors[attribute_component.health - 1]
	
func _player_no_health():
	print("Player died")
	MatchManager.player_died(name)
	await get_tree().create_timer(1).timeout
	reset_player()
	
func reset_player():
	attribute_component.reset_health()

	
	
	
	
	
	
	
	
	
