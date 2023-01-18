extends Node

@onready var raycast = get_parent().get_node("Head/RayCast3D")
@onready var camera = get_parent().get_node("Head/Camera3D") 
var damage = 2
const MAX_CAM_SHAKE = 0.1

func _physics_process(delta):
	if Input.is_action_pressed("fire"):
		get_parent().get_node("Head/AnimationPlayer").play("Fire")
		if raycast.is_colliding():
			print("hit")
			var target = raycast.get_collider()
			if target.is_in_group("Enemy"):
				target.health -= damage
				print("hit enemy")
			if target.is_in_group("Environment"):
				print("hit_env")
			else:
				print ("no hit")	
		camera.position = lerp(camera.position, Vector3(randf_range(MAX_CAM_SHAKE, -MAX_CAM_SHAKE),randf_range(MAX_CAM_SHAKE, -MAX_CAM_SHAKE),0),0.5)
	else:
		camera.position = Vector3()*delta

