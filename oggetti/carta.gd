extends Node
@onready var texture_button: TextureButton = $Node2D/TextureButton
@onready var node: Node2D = $Node2D
@onready var animation_player: AnimationPlayer = $Node2D/AnimationPlayer
@onready var node_2d_2: Node2D = $Node2D2

var playing = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_button.disabled = true
func anim():
	set_meta("pescata",false)		
	##animation_player.play("pesca")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	node.position += (node_2d_2.position-node.position)*0.01
	if(get_meta("pescata") == true):
		anim()
	pass
