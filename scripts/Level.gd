extends Node2D


@export var playerStart = [Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO ]
var title = ""
var diff:int = clampi(1, 1, 5)
@export var gravity = Vector2(0, 980)
@export var gravityDir:String = "down" 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = load("res://scenes/Player.tscn").instantiate()
	player.gravity = gravity
	add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
