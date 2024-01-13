extends Area2D

var speed = 110
var direction = Vector2(0,1)

func _ready():
	$AnimationPlayer.play("moving")
	
func _process(delta):
	position = position + direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
