extends CharacterBody2D

class_name player

const SPEED = 128.0
const ACCEL = 5.0

var input: Vector2

func _ready() -> void:
	Global.alive = true
	
	#if not Global.spawn_door_coords == null:
		#global_position = Global.spawn_door_coords
		
	#print(global_position)
	#print(Global.spawn_coords)
	
	Global.on_trigger_spawn.connect(on_spawn)

func get_input():
	input.x = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	input.y = Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	return input.normalized()
	
func _process(delta: float) -> void:
	var playerInput = get_input()
	
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
	
	if Global.alive:
		move_and_slide()

func on_spawn(position: Vector2, direction: String):
	global_position = position
	pass
