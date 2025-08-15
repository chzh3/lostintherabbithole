extends Node

var alive: bool
var score: int

#var spawn_door_coords
#
#var spawn_coords: Dictionary = {
	#
#}

var spawn_door_tag
signal on_trigger_spawn

var scene_to_load = {
	"level1": preload("res://scenes/level1.tscn"),
	"level2": preload("res://scenes/level2.tscn")
}

func go_to_level(scene_tag, door_tag):
	
	spawn_door_tag = door_tag
	get_tree().change_scene_to_packed.call_deferred(scene_to_load[scene_tag])
	#print(spawn_coords)
	#spawn_door_coords = spawn_coords[scene_tag][door_tag]
	
	pass
	
func spawn(position: Vector2, direction: String):
	
	on_trigger_spawn.emit(position, direction)
	
	pass
