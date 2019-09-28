import wollok.game.*
import personajes.*
import enemigos.*

class Item {
	var property poder = 0 // mayor poder, mejor item (los mejores items pueden ser usados si se tiene mucha dignidad)
	                       // poder seria como dignidad necesaria minima para llevarlo
	const property danioQueProvoca 
	
	method aumentarEstadistica(personaje,estadistica) {
		return personaje.estadistica() + poder
	}
	
	method agregarAtaque(nuevoAtaque,personaje) {
		personaje.ataques().add(nuevoAtaque)
	}
}
