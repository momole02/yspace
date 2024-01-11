extends Area2D


@export var player_position = Vector2(0,0)

# var bullet = preload("res://scenes/bullet.tscn")

var direction = Vector2(0,1)
var speed = 50

func _ready():
	$AnimationPlayer.play("moving")

func _process(delta):
	position = position + direction * speed * delta

func _on_shoot_timer_timeout():
	pass
#	var node = bullet.instantiate()
#	get_parent().add_child(node)
