extends Control

func _ready() -> void:
	
	# To use, Project Settings -> Netfox -> Autoconnect: Enable
	if NetworkSimulator.enabled:
		NetworkSimulator.server_created.connect(_on_sim_server_created)
		NetworkSimulator.client_connected.connect(_on_sim_client_connected)

func _on_host_game_pressed() -> void:
	NetworkManager.create_server()
	NetworkManager.load_game_scene()

func _on_join_game_pressed() -> void:
	NetworkManager.load_game_scene()
	NetworkManager.create_client()

func _on_sim_server_created() -> void:
	print("On sim server created")
	NetworkManager.is_hosting_game = true
	NetworkManager.load_game_scene()
	
func _on_sim_client_connected() -> void:
	print("on sim client connected")
	NetworkManager.is_hosting_game = false
	NetworkManager.load_game_scene()
