extends KinematicBody2D

const GRAVITY = 9.8
const SPEED = 10
const MAX_SPEED = 200
const JUMP_HEIGHT = 500

const FIREBALL = preload("res://Fireball.tscn")
const FIREBALL_POWER = preload("res://FireballPower.tscn")

var motion = Vector2();
var is_dead = false;

var fireball_power = 1

signal taking_damage

func read():
	$ShootSound.loop = false

func _physics_process(delta):
	
	if is_dead == false:	
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
		
		motion.y += GRAVITY	
	
		if Input.is_action_pressed("ui_right"):		
			motion.x += SPEED
							
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			motion.x -= SPEED
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1				
		else:
			motion.x = lerp(motion.x, 0, 0.1)		
			if motion.y < GRAVITY:
				$AnimatedSprite.play("Jump")
			if motion.y > GRAVITY:
				$AnimatedSprite.play("Fall")		
			if int(motion.y) == int(GRAVITY):
				$AnimatedSprite.play("Idle")
				
		if motion.x > MAX_SPEED:
			motion.x = MAX_SPEED
		if motion.x < -MAX_SPEED:
			motion.x = -MAX_SPEED				
			
		if is_on_floor():	
			if Input.is_action_just_pressed("ui_up"):
				motion.y -= JUMP_HEIGHT	
				
				
		if Input.is_action_just_pressed("ui_focus_next"):			
			$ShootSound.play()
			
			var fireball = FIREBALL.instance()
						
			if fireball_power == 1:
				fireball = FIREBALL.instance()
			elif fireball_power == 2: 
				fireball = FIREBALL_POWER.instance()
			
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			
			get_parent().add_child(fireball)			
			
			fireball.position = $Position2D.global_position
			
		motion = move_and_slide(motion, Vector2.UP);
		
#		if get_slide_count() > 0:
#			for i in range(get_slide_count()):
#				if "Enemy" in get_slide_collision(i).collider.name:
#					damage()
	
func damage():	
	print(Globals.player_health)
	if Globals.player_health == 1:
		dead()
	else:
		$AnimationPlayer.play("TakingDamage")
		Globals.player_health -= 1
		emit_signal("taking_damage")
	
func dead():
	is_dead = true
	motion = Vector2(0, 0)
	$AnimatedSprite.play("Dead")
	
	self.translate(Vector2(0, -10))
	if $CollisionShape2D != null:
		$CollisionShape2D.queue_free()
		
	$Timer.start()	
	Globals.enemy_kill_count = 0

func _on_Timer_timeout():
	get_tree().change_scene("res://TitleScreen.tscn")

func powerup():
	fireball_power = 2