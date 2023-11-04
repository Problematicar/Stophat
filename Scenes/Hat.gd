extends CharacterBody2D

const speed = 1000  # Adjust the speed as needed

func _process(delta):
	var motion = Vector2()

	if Input.is_action_pressed("_down"): motion.y += 1
	else: motion.y -= 1
	if Input.is_action_pressed("_left"): motion.x -= 1
	if Input.is_action_pressed("_right"): motion.x += 1

	motion = motion.normalized() * speed * delta
	move_and_collide(motion)

# :)
