extends Node
@onready var seleziona_gioco: Node2D = $"Seleziona gioco"
@onready var first_page: Node2D = $"First page"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seleziona_gioco.visible = false
	first_page.visible = true
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(first_page.get_meta("avanti")):
		seleziona_gioco.visible = true
		first_page.visible = false
	pass
