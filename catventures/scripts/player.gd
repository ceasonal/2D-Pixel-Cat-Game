extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var cat_state: int = 0 

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	
	# Restart game
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Handle Character Sprite
	if Input.is_action_just_pressed("change"):
		# Toggles through 0, 1, 2 Update the sprite based on the new state
		cat_state = (cat_state + 1) % 4 
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Flip Player
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	# Player Animation - Idle, Walking, Jump
	if is_on_floor():
		if direction == 0 :
			if cat_state == 0:
				animated_sprite_2d.play("orange_idle")
			elif cat_state == 1:
				animated_sprite_2d.play("peach_idle")
			elif cat_state == 2:
				animated_sprite_2d.play("grey_idle")

		else:
			if cat_state == 0:
				animated_sprite_2d.play("orange_walk")
			elif cat_state == 1:
				animated_sprite_2d.play("peach_walk")
			elif cat_state == 2:
				animated_sprite_2d.play("grey_walk")
				
	else:
		if cat_state == 0:
			animated_sprite_2d.play("orange_jump")
		elif cat_state == 1:
			animated_sprite_2d.play("peach_jump")
		elif cat_state == 2:
			animated_sprite_2d.play("grey_jump")
		

	move_and_slide()
