extends Node

var last_checkpoint_pos : Vector2 = Vector2.ZERO
var camera_at_checkpoint: bool = false

var player_boost = 1.0
var speed_coin_mult = 1.0
var jump_coin_mult = 1.0
var scene_num = 0
var crystal_amount = 0

var collected_speed_coins = []
var collected_jump_coins = []
func respawn_player(player_instance):
	if last_checkpoint_pos != Vector2.ZERO:
		player_instance.global_position = last_checkpoint_pos
		
		if camera_at_checkpoint:
			var camera = player_instance.get_node_or_null("Camera2D")
			if camera:
				camera.reset_smoothing() 
