extends Node2D

@onready var tile_map_layer = $"../TileMapLayer"
@onready var sprite_2d = $Sprite2D
@onready var ray_cast_2d = $RayCast2D

var is_moving: bool = false
var held_keys = []

func _physics_process(_delta):
	if is_moving == false:
		return
	
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 1)

	if global_position == sprite_2d.global_position:
		is_moving = false
		return
		

func _process(_delta):
	if is_moving:
		return

	if Input.is_action_pressed("up"):
		if Vector2.UP not in held_keys:
			held_keys.insert(0, Vector2.UP)
	else:
		held_keys.erase(Vector2.UP)
		
	if Input.is_action_pressed("down"):
		if Vector2.DOWN not in held_keys:
			held_keys.insert(0, Vector2.DOWN)
	else:
		held_keys.erase(Vector2.DOWN)
		
	if Input.is_action_pressed("left"):
		if Vector2.LEFT not in held_keys:
			held_keys.insert(0, Vector2.LEFT)
	else:
		held_keys.erase(Vector2.LEFT)
		
	if Input.is_action_pressed("right"):
		if Vector2.RIGHT not in held_keys:
			held_keys.insert(0, Vector2.RIGHT)
	else:
		held_keys.erase(Vector2.RIGHT)
	
	if held_keys.size() > 0:
		move(held_keys[0])

func move(direction: Vector2):
	# Get cureent tile Vector2i
	var current_tile: Vector2i = tile_map_layer.local_to_map(global_position)
	
	# Get target tile Vector2i
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	
	# Get custom data layer from the target tile
	var tile_data: TileData = tile_map_layer.get_cell_tile_data(target_tile)
	if tile_data.get_custom_data("walkable") ==  false:
		return
	
	# Check for collisions
	ray_cast_2d.target_position = direction * 16
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():
		return
	
	# Move player
	is_moving = true
	global_position = tile_map_layer.map_to_local(target_tile)
	sprite_2d.global_position = tile_map_layer.map_to_local(current_tile)
