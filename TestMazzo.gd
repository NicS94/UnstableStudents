extends Node
@onready var file = 'res://mazzo/mazzo.txt'
var scene = load("res://oggetti/carta.res")  # Carica la scena
@onready var mc: Node2D = $mazzo
@onready var button: Button = $Button

func getQuando(tipo) -> String:
	var arr = ["SUBITO","INIZIO","FINE","MAI","SEMPRE"]
	return arr[tipo]
	
func getAzione(tipo) -> String:
	var arr = ["GIOCA","SCARTA","ELIMINA","RUBA","PESCA","PRENDI","BLOCCA","SCAMBIA","MOSTRA","IMPEDIRE","INGENIERE"]
	return arr[tipo]

func getTipologia(tipo) -> String:
	var arr = ["ALL","STUDENTE","MATRICOLA","STUDENTE_SEMPLICE","LAUREANDO","BONUS","MALUS","MAGIA","ISTANTANEA"]
	return arr[tipo]

func getTarget(tipo) -> String:
	var arr = ["IO","TU","VOI","TUTTI"]
	return arr[tipo]

func load_file(file) -> Array:
	var mazzo =[]
	var f = FileAccess.open(file,FileAccess.READ)
	var instance
	var numeroCarte
	var copia 
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		
		numeroCarte = int(f.get_line())
		instance = scene.instantiate()  # Crea un'istanza
		instance.set_meta("nome",f.get_line())
		instance.set_meta("descr",f.get_line())
		instance.set_meta("tipo",f.get_line())
		instance.set_meta("numEffetti",int(f.get_line()))
		var eff = []
		if instance.get_meta("numEffetti")>0:
			for i in range(instance.get_meta("numEffetti")):
				eff.append(f.get_line().split(" "))
		set_meta("effetti",eff)
		instance.set_meta("quando",int(f.get_line()))
		instance.set_meta("opzionale",int(f.get_line()))
		mazzo.append(instance)
		copia = instance.duplicate()
		for i in range(numeroCarte):
			mazzo.append(copia.duplicate())
	f.close()
	return mazzo
	
var mazzo

func _ready():
	mazzo = load_file(file)
	mostraMazzo(mazzo)
	
func mostraMazzo(mazzo):
	for carta in mazzo:
		mc.add_child(carta)
var pressed = false

func svolgi():
	var carta = mazzo.pop_front()
	carta.set_meta("pescata",true)
	print(carta.get_meta("nome"))
	
func pesca(): 
	pressed = true
	svolgi()
	await get_tree().create_timer(2).timeout
	pressed = false

func resetbool():
	pressed = false

func _process(delta: float) -> void:
	if(button.button_pressed && pressed == false): 
		pesca()
	pass
