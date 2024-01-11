extends Area2D

@export var speed = 20
@export var player_position = Vector2(0,0)

var direction = Vector2(0,1)

func _ready():
	direction = (global_position - player_position).normalized()
	
func _process(delta):
	position = position + direction * speed * delta
