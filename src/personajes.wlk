import wollok.game.*
import items.*
import nivel.*
import extras.*

class Personaje {

	var ataque
	var vida
	var velocidad
	var items = []
	var itemEnMano
	var killsCounter = 0
	var position = game.at(12, 4)

	method position() = position

	method image()

	method moverse(nuevaPosicion, orientacion,personaje) {
		if (self.puedeMoverse(orientacion,personaje)) {
			position = nuevaPosicion
		} // else no se mueve
	}

	method puedeMoverse(orientacion,personaje) {
		return orientacion.posicionEnEsaDireccion(personaje).allElements().all({ objeto => objeto.esAtravesable() })
	}

	method ponerItemSiguienteEnMano() {
		if (!items.isEmpty()) {
			var item = items.head()
			items.remove(item)
			items.add(item)
			itemEnMano = items.head() // poner que se actualice la img cuando esten hechos los items
		} // else "inventario vacio"
	}

	method dejarItemEnMano() {
		items.remove(itemEnMano)
	}

	method agarrarItem(nuevoItem) {
		if (self.position() == nuevoItem.position()) {
			if (items.size() < 3) {
				items.add(nuevoItem)
				game.removeVisual(nuevoItem)
			} // else "inventario lleno"	
		}
	}

	method mejorarEstadisticas() {
		itemEnMano.aumentarEstadistica(self)
	}

	method dignidad() {
		return 100 * killsCounter
	}

	method matar(enemigo) {
		enemigo.morir()
		killsCounter++
	}

}

object scorpion inherits Personaje {

	override method image() = "scorpion.png"

}

object gandalf inherits Personaje {

	override method image() = "gandalf.png"

}

/* 
 * object scorpion inherits Personaje { 
 * 	
 * 	override method image() = "scorpion2.png"
 * 	
 * 	method dignidad() {                          // la dignidad se la da el poder de los items
 * 		return items.sum({item => item.poder()})
 * 	}
 * 	
 * 	method mejorarEstadisticas() {
 * 		items.forEach({item => item.aumentarEstadistica(self)})
 * 	}
 * 	 
 * 	method pelear(enemigo) {
 * 		item.ataques().danioQueProvoca(enemigo)
 * 	}
 * 	
 * 	method agregarItem(nuevoItem) {    // deberia poder elegir el item que deja????
 * 		if(items.size() >= 3){
 * 			self.dejarItemDeMenorPoder()
 * 			items.add(nuevoItem)
 * 		} else{
 * 			items.add(nuevoItem)
 * 		}
 * 	}
 * 	
 * 	method dejarItemDeMenorPoder(){
 * 		items.remove(items.min({item => item.poder()}))
 * 	}
 * }
 */
