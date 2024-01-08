extends Area2D
const INITIAL_H_FRAME = 2

var h_frame = INITIAL_H_FRAME
var v_frame = 0
var h_frame_incr = 0

var leaning_left = false 
var leaning_right = false

var speed = 100


var direction = Vector2(0,0)
func _on_v_frame_timer_timeout():
	v_frame = (v_frame + 1) % 2

func _on_h_frame_timer_timeout():
	if leaning_left: # on est en train d'aller a gauche 
		h_frame = max(h_frame - 1, 0)
	elif leaning_right: # on est entrain d'aller à droite
		h_frame = min(h_frame + 1 , 4)
	else:
		# homéostasie, on retourne à la position initiale
		if(h_frame != INITIAL_H_FRAME):
			h_frame = h_frame + sign(INITIAL_H_FRAME - h_frame)
			
		
func _process(delta):
	leaning_left = Input.is_action_pressed("lean_left")
	leaning_right = Input.is_action_pressed("lean_right")
	direction = Input.get_vector("lean_left", "lean_right", "move_up", "move_down") * speed
	$Sprite2D.frame = h_frame + v_frame * 5
	position = position + direction * delta 