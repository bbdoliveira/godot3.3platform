extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 480
var gravity = 1200
var jump_force = -820
var is_grounded #Vai verificar se ele esta no chão!
onready var raycasts = $raycasts


#================Função principal que faz o game Roda!=========================#

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	_get_input()

	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_grounded()
	
	_set_animation()
	
#	print (velocity.y)
#=============================================================================#

#Faz a movimentação do Player
func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))	
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	#Verifica para qual lado o player vai e vira a textura.
	if move_direction !=0:
		$texture.scale.x = move_direction
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_force / 2
	
	if event.is_action_pressed("run"):
		move_speed = 800
#		print(move_speed)
	elif event.is_action_released("run"):
		move_speed = 480
#		print(move_speed)
		

func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false

func _set_animation():
	var anim = "idle"
	
	if !is_grounded:
		anim = "jump"
	elif velocity.x !=0:
		anim = "run"
		
	if velocity.y > 0 and !is_grounded:
		anim = "run"
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)
