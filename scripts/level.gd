extends Node2D

func _ready() -> void:
	if Global.spawn_door_tag != null:
		on_spawn(Global.spawn_door_tag)
	
	Global.score = int(name.substr(name.length() - 1, 1))
	print(Global.score)
		
func on_spawn(door_tag: String):
	var door = get_node("door_" + door_tag)
	Global.spawn(door.spawn.global_position, door.spawn_dir)
	pass
