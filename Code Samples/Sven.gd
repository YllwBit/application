extends CharacterBody2D

# This is the script that controls the Player Character

@onready var _animated_sprite = $SvenAnimatedSprite2D

const SPEED = 400.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_pressed("right") :
		$SvenAnimatedSprite2D.flip_h = false
		_animated_sprite.play("SvenWalk")

	if Input.is_action_just_released("right"):
			_animated_sprite.play("SvenIdle")
			

# Flips sprite 
	if Input.is_action_pressed("left") :
		$SvenAnimatedSprite2D.flip_h = true
		_animated_sprite.play("SvenWalk")
# Starts Idle Animation
	if Input.is_action_just_released("left"):
			_animated_sprite.play("SvenIdle")


		

	move_and_slide()
