extends Node2D


func _ready():
	$AnimationPlayer.play("explode")
	$ExplosionSFX.play()


func _on_animation_player_animation_finished(anim_name):
	queue_free()
