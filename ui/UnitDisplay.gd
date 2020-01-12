extends Node2D

var bar_red = preload("res://assets/ui/barHorizontal_red_mid 200.png")
var bar_yellow = preload("res://assets/ui/barHorizontal_yellow_mid 200.png")
var bar_green = preload("res://assets/ui/barHorizontal_green_mid 200.png")
var bar_texture

func _ready():
	for node in get_children():
		node.hide()

func _process(delta):
	global_rotation = 0

func update_healthbar(value):
	bar_texture = bar_green
	if value < 100:
		$HealthBar.show()
	if value < 60:
		bar_texture = bar_yellow
	if value < 25:
		bar_texture = bar_red
	$HealthBar.texture_progress = bar_texture
	$HealthBar.value = value
