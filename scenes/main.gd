extends Node2D

const enemy_big_scene = preload("res://scenes/enemy_big.tscn")
const enemy_medium_scene = preload("res://scenes/enemy_medium.tscn")
const enemy_small_scene = preload("res://scenes/enemy_small.tscn")
const player_scene = preload("res://scenes/player.tscn")
var player_node: Node

var score = 0 

var 	enemy_big_gen_ticks = 0
var 	enemy_big_gen_time = 0
const 	enemy_big_gen_max_secs = 10 
const 	enemy_big_gen_min_secs = 5 

var 	enemy_medium_gen_ticks = 0
var 	enemy_medium_gen_time = 0
const 	enemy_medium_gen_max_secs = 7
const 	enemy_medium_gen_min_secs = 3

var		enemy_small_gen_ticks = 0
var 	enemy_small_gen_time = 0
const 	enemy_small_gen_max_secs = 2
const 	enemy_small_gen_min_secs = 0.5

func _ready():
	player_node = $Player
	get_window().size = Vector2i(512, 512)
	enemy_big_gen_time = randi_range(enemy_big_gen_min_secs, enemy_big_gen_max_secs)
	init()
	$MusicPlayer.play()
		
func init():
	if player_node == null: 
		player_node = player_scene.instantiate()
		player_node.position.x = 256 / 2 - 5
		player_node.position.y = 256 - 10
		player_node.connect("killed", _on_player_killed)
		add_child(player_node)
		
	$GameOverLabel.visible = false 
	score = 0
	_format_score()
	$ScoreTimer.start()
	

func _format_score():
	$ScoreLabel.text = "%d"%score
	$ScoreLabel.text = $ScoreLabel.text.lpad(8, "0")

func _process(delta):
	if player_node != null:
		handle_gen_enemy_small(delta)
		handle_gen_enemy_medium(delta)
		handle_gen_enemy_big(delta)
	else:
		if Input.is_action_just_pressed("shoot"):
			init()
	
func handle_gen_enemy_big(delta):
	enemy_big_gen_ticks = enemy_big_gen_ticks + delta
	if enemy_big_gen_ticks >= enemy_big_gen_time:
		generate_enemy_big()
		print("Big enemy gen after ", enemy_big_gen_time, "s")
		
func generate_enemy_big():
	var node = enemy_big_scene.instantiate()
	node.position.x = randf_range(10,200)
	node.position.y = -10
	node.player_node = player_node
	node.connect("killed", _on_enemy_big_killed)
	add_child(node)
	enemy_big_gen_time = randi_range(enemy_big_gen_min_secs, enemy_big_gen_max_secs)
	enemy_big_gen_ticks = 0 
	
func handle_gen_enemy_medium(delta): 
	enemy_medium_gen_ticks = enemy_medium_gen_ticks + delta
	if enemy_medium_gen_ticks >= enemy_medium_gen_time:
		generate_enemy_medium()
		print("Med enemy gen after ", enemy_medium_gen_time, "s")

func generate_enemy_medium():
	var node = enemy_medium_scene.instantiate()
	node.position.x = randf_range(10,200)
	node.position.y = -10
	node.connect("killed", _on_enemy_med_killed)
	add_child(node)
	enemy_medium_gen_time = randi_range(enemy_medium_gen_min_secs , enemy_medium_gen_max_secs)
	enemy_medium_gen_ticks = 0
	
func handle_gen_enemy_small(delta):
	enemy_small_gen_ticks = enemy_small_gen_ticks + delta
	if enemy_small_gen_ticks >= enemy_small_gen_time:
		generate_enemy_small()
		print("Small enemy gen after ", enemy_small_gen_time, "s")

func generate_enemy_small(): 
	var node = enemy_small_scene.instantiate()
	node.position.x = randf_range(10,200)
	node.position.y = -1
	var direction = player_node.position - node.position
	node.direction = direction.normalized()
	node.connect("killed", _on_enemy_small_killed)
	add_child(node)
	enemy_small_gen_time = randi_range(enemy_small_gen_min_secs, enemy_small_gen_max_secs)
	enemy_small_gen_ticks = 0
	

func _on_player_killed():
	print("Player killed")
	$GameOverLabel.visible = true
	
	
func _on_enemy_big_killed():
	score = score + 3
	_format_score()

func _on_enemy_med_killed():
	score = score + 2 
	_format_score()

func _on_enemy_small_killed():
	score = score + 1
	_format_score()

func _on_score_timer_timeout():
	if player_node != null:
		score = score + 1
		_format_score()
		
