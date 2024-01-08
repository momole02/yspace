extends Node2D

var scroll_speed = 50 

func _ready():
	$Sprite2D.region_rect.position.y = 256
	print($Sprite2D.region_rect)
	
func _process(delta):
	var scroll_y = $Sprite2D.region_rect.position.y - scroll_speed * delta
	if scroll_y  <= 0:
		scroll_y = $Sprite2D.texture.get_height() - 304 - scroll_y
	$Sprite2D.region_rect.position.y = scroll_y
	
