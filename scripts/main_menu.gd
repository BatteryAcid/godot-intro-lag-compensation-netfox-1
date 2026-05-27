extends Control


func _on_host_game_pressed() -> void:
	NetworkManager.create_server()
	NetworkManager.load_game_scene()

func _on_join_game_pressed() -> void:
	NetworkManager.load_game_scene()
	NetworkManager.create_client()
