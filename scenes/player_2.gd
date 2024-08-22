extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if  direction > 0:
		animated_sprite.flip_h= false
	elif  direction < 0:
		 animated_sprite.flip_h= true
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
			
		else:
			animated_sprite.play("run") 
	else:
		if velocity.y > 0:
				animated_sprite.play("fall") 
		else:
				animated_sprite.play("jump") 
	  	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)



	move_and_slide()
