import wollok.game.*
import personajes.*
import enemigos.*
import ataques.*

object espada {
	var poder = 75 // mayor poder, mejor item (los mejores items pueden ser usados si se tiene mucha dignidad en el caso del personaje)
	                       // poder seria como dignidad necesaria minima para llevarlo si lo lleva un personaje (no enemigo) ?????? 
	const ataques = #{ataqueDeEspada} 
	
	method poder() = poder
	
	method cambiarPoder(nuevoPoder) = (poder = nuevoPoder)
		
	method aumentarEstadistica(personaje) {  // para el que lo usa ( solo personajes ?? )
		return personaje.dignidad() + poder
	}
	
	method agregarAtaque(nuevoAtaque,personaje) {
		personaje.ataques().add(nuevoAtaque)
	}
}

