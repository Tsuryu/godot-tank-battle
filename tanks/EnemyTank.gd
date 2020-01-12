extends "res://tanks/Tank.gd"

onready var parent = get_parent()

export (float) var turret_speed
export (int) var detect_radius

var speed = 0
var target = null

func _ready():
	var circle = CircleShape2D.new()
	$DetectArea/CollisionShape2D.shape = circle
	$DetectArea/CollisionShape2D.shape.radius = detect_radius

func control(delta):
	if parent is PathFollow2D:
		if $LookAhead1.is_colliding() or $LookAhead2.is_colliding():
			speed = lerp(speed, 0, 0.1)
		else:
			speed= lerp(speed, max_speed, 0.05)
			parent.set_offset(parent.get_offset() + speed * delta)
			position = Vector2()
	else:
		# other movement
		pass

func _process(delta):
	if target:
		var target_direction = (target.global_position - global_position).normalized()
		var current_direction = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation = current_direction.linear_interpolate(target_direction, turret_speed * delta).angle()
		if target_direction.dot(current_direction) > 0.9:
			shoot()

func _on_DetectArea_body_entered(body):
	if body.name == 'Player':
		target = body

func _on_DetectArea_body_exited(body):
	if body == target:
		target = null
