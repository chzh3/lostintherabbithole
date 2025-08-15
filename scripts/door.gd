extends Area2D

@export var target_scene: String
@export var target_door: String
@export var spawn_dir: String

@onready var spawn: Marker2D = $spawn

func _ready() -> void:
	#if not Global.spawn_coords.has(this_scene):
		#Global.spawn_coords[this_scene] = {}
	#if not Global.spawn_coords[this_scene].has(this_door):
		#Global.spawn_coords[this_scene][this_door] = $spawn.global_position
		#
	#print($spawn.global_position)
	#print(Global.spawn_coords)
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is player:
		Global.go_to_level(target_scene, target_door)
	pass # Replace with function body.
