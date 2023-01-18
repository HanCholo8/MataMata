extends CharacterBody3D

@onready var agent : NavigationAgent3D = $agent
@onready var target : CharacterBody3D = $"/root/L_Main/Player"
@onready var E_raycast : RayCast3D = $E_RayCast
@onready var E_raycast_L : RayCast3D = $E_RayCast_L
@onready var E_raycast_R : RayCast3D = $E_RayCast_R
@onready var E_raycast_L2 : RayCast3D = $E_RayCast_L2
@onready var E_raycast_R2 : RayCast3D = $E_RayCast_R2

const distance = 3
var E_lookdistance = 10
@export var speed = 5
var health = 100
var look_vel = 100
#var or_velocity = global_transform.origin
@export var gravity_multiplier := 3.0
@onready var gravity: float = (ProjectSettings.get_setting("physics/3d/default_gravity") 
		* gravity_multiplier)
# Manages look player
func _physics_process(delta):
	var current_location = global_transform.origin*delta
	var next_location = agent.get_next_location()*delta
	var new_velocity = (next_location - current_location).normalized() * speed * delta
	var E_target = E_raycast.get_collider()
	var E_target_L =  E_raycast_L.get_collider()
	var E_target_R = E_raycast_R.get_collider()
	var E_target_L2 =  E_raycast_L2.get_collider()
	var E_target_R2 = E_raycast_R2.get_collider()
	
	agent.set_velocity(next_location-current_location)
	#	look_at_player((next_location - current_location))

	if E_raycast.is_colliding():
		if E_target.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) < E_lookdistance:
			look_at_player((next_location - current_location))
			print("look")
	if E_raycast_L.is_colliding():
		if E_target_L.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) < E_lookdistance:
			look_at_player((next_location - current_location))
			print("lookL")
	if E_raycast_R.is_colliding():
		if E_target_R.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) < E_lookdistance:
			look_at_player((next_location - current_location))
			print("lookR")
	if E_raycast_L2.is_colliding():
		if E_target_L2.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) <E_lookdistance:
			look_at_player((next_location - current_location))
			print("lookL2")
	if E_raycast_R2.is_colliding():
		if E_target_R2.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) < E_lookdistance:
			look_at_player((next_location - current_location))
			print("lookR2")
	else:
		return

# Manages stats & deltas
func _process(delta):
	if health * delta <= 0 :
		queue_free()
		print("dead")

# Manages target loc
func update_target_location(target_location):
	agent.set_target_location(target_location)

# look func
func look_at_player(target_location):
	if target_location != null and target_location != global_transform.origin:
		look_at((target_location*-1).normalized() * look_vel, Vector3.UP)
	
#checked reached player actions
func _on_agent_target_reached():
	
	$AnimationPlayer.play("Attack")
	print("attack")
#Velocity compute
func _on_agent_velocity_computed(safe_velocity):
	
	velocity = velocity.move_toward(safe_velocity, 0.005)
	velocity.y -= gravity * get_process_delta_time()
	var E_target = E_raycast.get_collider()
	var E_target_L =  E_raycast_L.get_collider()
	var E_target_R = E_raycast_R.get_collider()
	var E_target_L2 =  E_raycast_L2.get_collider()
	var E_target_R2 = E_raycast_R2.get_collider()

	if E_raycast.is_colliding():
		if E_target.is_in_group("Player")and transform.origin.distance_to(target.transform.origin) > distance:
			move_and_collide(safe_velocity)
			print("move")
			return
	if E_raycast_L.is_colliding():
		if E_target_L.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) > distance:
			move_and_collide(safe_velocity)
			print("moveL")
			return
	if E_raycast_R.is_colliding():
		if E_target_R.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) > distance:
			move_and_collide(safe_velocity)
			print("moveR")
			return
	if E_raycast_L2.is_colliding():
		if E_target_L2.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) > distance:
			move_and_collide(safe_velocity)
			print("moveL2")
			return
	if E_raycast_R2.is_colliding():
		if E_target_R2.is_in_group("Player") and transform.origin.distance_to(target.transform.origin) > distance:
			move_and_collide(safe_velocity)
			print("moveR2")
			return
	else:
		return
