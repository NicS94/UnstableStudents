extends Node
@onready var file = 'res://mazzo/mazzo.txt'
var scene = load("res://oggetti/carta.res")  # Carica la scena

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

func _ready():
	var offset = Vector2(3,0)
	load_file(file,offset)

func load_file(file,offset) -> void:
	
	var f = FileAccess.open(file,FileAccess.READ)

	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		
		var numeroCarte = int(f.get_line())
		var instance = scene.instantiate()  # Crea un'istanza
		instance.position += offset
		offset+= Vector2(2,0)
		add_child(instance)  # Aggiunge l'istanza alla scena corrente
		
		
		var nome = f.get_line()
		var descr = f.get_line()
		var tipologia = int (f.get_line())
		var numEffetti = f.get_line()
		print("NOME: "+nome+"\n"+"Descrizione: "+descr+"\n"+"tipologia: "+getTipologia(int(tipologia))+"\n"+"Effetti?: "+numEffetti+"\n")
		numEffetti = int(numEffetti)
		var eff = []
		if numEffetti>0:
			for i in range(numEffetti):
				eff.append(f.get_line().split(" "))
				for e in eff:
					print(getAzione(int(e[0]))+" "+getTarget(int(e[1]))+" "+getTipologia(int(e[2])))
					
					
		else:
			print("\nnon ha effetti...")
		var quando = f.get_line()
		var opzionale = f.get_line()
		print("Quando: "+getQuando(int(quando)) + " Opzionale:"+ "si" if opzionale else "no")
		print("\n\n\n\n")
		for i in range(numeroCarte):
			var copia = instance.duplicate()
			copia.position += offset 
			add_child(copia)
	f.close()
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
