extends Area2D

signal killed

@export var player_node: Node

var bullet = preload("res://scenes/bullet.tscn")
var explosion = preload("res://scenes/explosion.tscn")

var shoot_ticks = 0
var shoot_time = 0
var shoot_min_secs = 0
var shoot_max_secs = 1.5

var direction = Vector2(0,1)
var speed = 50

func _ready():
	$AnimationPlayer.play("moving")
	shoot_time = randf_range(shoot_min_secs, shoot_max_secs)

func _process(delta):
	shoot_ticks = shoot_ticks + delta
	if shoot_ticks > shoot_time: 
		shoot() 
		shoot_ticks = 0
		shoot_time = randf_range(shoot_min_secs, shoot_max_secs)
		
	position = position + direction * speed * delta

func shoot():
	if player_node != null: 
		print("Big enemy is shooting ... ")
		var node = bullet.instantiate()
		node.global_position = global_position
		var bullet_direction = player_node.global_position - node.global_position
		print("Bullet direction ", bullet_direction)
		node.direction = bullet_direction.normalized()
		get_parent().add_child(node) 
	
	
func _on_area_entered(area):
	queue_free()
	area.queue_free()
	var expl = explosion.instantiate()
	expl.global_position = global_position
	get_parent().add_child(expl)
	killed.emit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
