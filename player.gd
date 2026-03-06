extends CharacterBody2D
class_name player 

@export var normal_speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var push_force: float = 1200.0 

var is_sticking: bool = false
var sticky_target: RigidBody2D = null

@onready var sprite = $sprite

func _ready():
	if GameManager.last_checkpoint_pos != Vector2.ZERO:
		global_position = GameManager.last_checkpoint_pos

func die():
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_sticking and is_instance_valid(sticky_target):
		velocity = sticky_target.linear_velocity
		move_and_slide()
		return 

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true 
	
	var is_dashing = Input.is_action_pressed("ui_accept")
	
	if direction != 0:
		var speed_mult = 2.0 if is_dashing else 1.0
		velocity.x = direction * (normal_speed * speed_mult)
	else:
		velocity.x = move_toward(velocity.x, 0, normal_speed)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
