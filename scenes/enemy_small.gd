extends Area2D

signal killed

var explosion = preload("res://scenes/explosion.tscn")
var direction = Vector2(0,1)
var speed = 100

func _ready():
	$AnimationPlayer.play("moving")

func _process(delta):
	position = position + direction * speed * delta

func _on_shoot_timer_timeout():
	pass
#	var node = bullet.instantiate()
#	get_parent().add_child(node)

func _on_area_entered(area): 
	#Lorsqu'il est touché par le laser du joueur
	queue_free()
	area.queue_free()
	var exp = explosion.instantiate()
	exp.global_position = global_position
	get_parent().add_child(exp)
	killed.emit()



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
