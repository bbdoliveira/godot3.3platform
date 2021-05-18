extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 480
var gravity = 1200
var jump_force = -720
var is_grounded #Vai verificar se ele esta no chão!
onready var raycasts = $raycasts

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	_get_input()

	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_grounded()

#Faz a movimentação do Player
func _get_input():
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))	
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	#Verifica para qual lado o player vai e vira a textura.
	if move_direction !=0:
		$texture.scale.x = move_direction

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_force / 2

func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false
