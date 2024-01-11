extends Node2D

const enemy_big_scene = preload("res://scenes/enemy_big.tscn")
const enemy_medium_scene = preload("res://scenes/enemy_medium.tscn")
const enemy_small_scene = preload("res://scenes/enemy_small.tscn")

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
const 	enemy_small_gen_max_secs = 5
const 	enemy_small_gen_min_secs = 2

func _ready():
	get_window().size = Vector2i(512, 512)
	enemy_big_gen_time = randi_range(enemy_big_gen_min_secs, enemy_big_gen_max_secs)
	
func _process(delta):
	handle_gen_enemy_small(delta)
	handle_gen_enemy_medium(delta)
	handle_gen_enemy_big(delta)
	
func handle_gen_enemy_big(delta):
	enemy_big_gen_ticks = enemy_big_gen_ticks + delta
	if enemy_big_gen_ticks >= enemy_big_gen_time:
		generate_enemy_big()
		print("Big enemy gen after ", enemy_big_gen_time, "s")
		
func generate_enemy_big():
	var node = enemy_big_scene.instantiate()
	node.position.x = $Player.position.x + randi_range(-10,10)
	node.position.y = -10
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
	node.position.x = $Player.position.x + randi_range(-10, 10)
	node.position.y = -10
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
	node.position.x = $Player.position.x + randi_range(-10, 10)
	node.position.y = -1
	add_child(node)
	enemy_small_gen_time = randi_range(enemy_small_gen_min_secs, enemy_small_gen_max_secs)
	enemy_small_gen_ticks = 0
	

