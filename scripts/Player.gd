extends CharacterBody2D



@export var playerType = "Player"
@export var playerCharacter = "Mario"
@export var maxSpeed:float =  180
@export var maxWSpeed:float =  75
@export var maxRSpeed:float =  135
@export var maxPSpeed:float =  180
@export var playerAccelRate:float = 337.5
@export var playerWalkRate:float = 75
@export var playerRunRate:float = 400
@export var playerPRunRate:float = 650
@export var playerJumpPower:float = 400
@export var playerNatDecelRate:float = 50
@export var playerTurnDecelRate:float = 999 
@export var playerPSpeed:bool = false
@export var pspeedPause:bool = false
@export var p_meter:float = 0
@export var p_meter_max:float = 0
@export var p_meter_speed:float = 0
@export var powerup = ""
@export var riding = ""
var hat = ""
var badges = []
var movesets = ["normal"]
var oldpos = Vector2.ZERO
var health
var gravityOffset = Vector2.ZERO
var gravity = Vector2.ZERO
var facing_dir
var curAnim:String = "Idle" 
var oldAnim:String = ""
var animSpeed:float = 5
@onready var Sprite = $PlayerSprite


func _physics_process(delta: float) -> void:
	_getRunType()
	doMovement(delta)
	handleAnimation()
	move_and_slide()

func _getRunType():
	pass
	
func doMovement(delta):
		#var gravity = Level.gravity + gravityoffset
	# Add the gravity.
	if not is_on_floor():
		velocity += (gravity + gravityOffset) * delta

	# Handle jump.
	if Input.is_action_just_pressed("game_jump") and is_on_floor():
		velocity.y = 0 - playerJumpPower

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("game_left", "game_right")
	if direction:
		var velDir = sign(velocity.x)
		if direction == velDir:
			velocity.x += direction * playerAccelRate * (delta * 60)
		else:
			velocity.x += direction * playerTurnDecelRate * (delta * 60)
		# Clamp to maxSpeed after acceleration
		velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
		setAnim("Walk")
		facing_dir = direction
	else:
		if velocity == Vector2.ZERO:
			setAnim()
			
		velocity.x -= move_toward(velocity.x, 0, playerNatDecelRate) * (delta * 60)


# Check if an animation exists in AnimatedSprite2D
func has_anim(anim_name: String) -> bool:
	if Sprite and Sprite.sprite_frames:
		return Sprite.sprite_frames.has_animation(anim_name)
	return false
	
func handleAnimation():
	if curAnim != oldAnim:
		if has_anim(curAnim):
			Sprite.play(curAnim)
		else:
			Sprite.play("Idle")
		print("set animation to " + curAnim)
		
func setAnim(n = "Idle", sp = 60):
	oldAnim = curAnim
	curAnim = n
	animSpeed = sp
