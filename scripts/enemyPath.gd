extends Path2D

var speed = .1
var direction: String

var past: Vector2
var current: Vector2
var pastDir

signal directionChange

func _ready() -> void:
	align_to_grid()
	check_rotation()
	change_rotation()
	self.directionChange.connect(self.change_rotation)

func _process(delta: float) -> void:
	
	if $PathFollow2D.progress_ratio >= 1 or $PathFollow2D.progress_ratio <= 0:
		speed *= -1
	$PathFollow2D.progress_ratio +=  delta * speed
	
	check_rotation()
	
	pass

func align_to_grid():
	var newCurve:Curve2D = Curve2D.new()
	var controlPoints = []
	for i in range(curve.point_count):
		controlPoints.append(curve.get_point_position(i))
	
	for i in controlPoints:
		var pathX:int = i.x
		var pathY:int = i.y
		
		var newPoint: Vector2
		newPoint.x = pathX - (int(global_position.x) + pathX) % 32 + 16
		newPoint.y = pathY - (int(global_position.y) + pathY) % 32 + 16
		
		newCurve.add_point(newPoint)
		
	curve = newCurve

func check_rotation():
	pastDir = direction
	
	current = $PathFollow2D/Node2D.global_position
	if past.x != null:
		if current.x > past.x:
			direction = "right"
		elif current.x < past.x:
			direction = "left"
		elif current.y < past.y:
			direction = "up"
		elif current.y > past.y:
			direction = "down"
	past = $PathFollow2D/Node2D.global_position
	
	if not pastDir == direction:
		directionChange.emit()

func change_rotation():
	match direction:
		"right":
			$PathFollow2D/Node2D/range.rotation_degrees = 0
		"left":
			$PathFollow2D/Node2D/range.rotation_degrees = 180
		"up":
			$PathFollow2D/Node2D/range.rotation_degrees = 270
		"down":
			$PathFollow2D/Node2D/range.rotation_degrees = 90
	pass


func _on_range_body_entered(body: Node2D) -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = .5
	timer.one_shot = true
	timer.timeout.connect(_on_range_timer_timeout)
	
	if  body is player:
		timer.start()
		speed /= 4
		
	pass # Replace with function body.

func _on_range_timer_timeout():
	speed *= 16
	
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	timer.timeout.connect(_on_speed_timer_timeout)
	timer.start()
	pass
	
func _on_speed_timer_timeout():
	speed /= 4

func _on_killzone_timer_timeout():
	get_tree().reload_current_scene()
	pass

func _on_killzone_body_entered(body: Node2D) -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = .25
	timer.one_shot = true
	timer.timeout.connect(_on_killzone_timer_timeout)
	
	if body is player:
		timer.start()
		Global.alive = false
	
	pass # Replace with function body.
