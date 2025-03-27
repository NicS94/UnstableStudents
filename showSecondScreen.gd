extends Node
@onready var button: Button = $Node2D/Button
@onready var first_page: Node2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_meta("avanti",button.button_pressed)
	pass
