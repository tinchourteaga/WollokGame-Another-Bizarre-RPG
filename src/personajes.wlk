import wollok.game.*
import items.*
import nivel.*

class Personaje {
	
	var ataque
	var vida
	var velocidad
	var items = []
	var itemEnMano
	var killsCounter = 0
	var position = game.at(3,3)
	
	method position() = position
	
	method modificarPosicion(nuevaPosicion) = (position = nuevaPosicion)
	
	method image()
	
	method moverse(nuevaPosicion) { // De esta forma no se va mas alla de los bordes de la ventana
		if(nuevaPosicion.x().between(-1,10) && nuevaPosicion.y().between(-2,9)){
			position = nuevaPosicion	
		}	
	}
	
	method ponerItemSiguienteEnMano() {
		if(!items.isEmpty()) {
			var item = items.head()
			items.remove(item)
			items.add(item)
			itemEnMano = items.head() //poner que se actualice la img cuando esten hechos los items
		}// else "inventario vacio"
		
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
	
	override method image() = "scorpion2.png"
	
	
	
	
}

/* 
object scorpion inherits Personaje { 
	
	override method image() = "scorpion2.png"
	
	method dignidad() {                          // la dignidad se la da el poder de los items
		return items.sum({item => item.poder()})
	}
	
	method mejorarEstadisticas() {
		items.forEach({item => item.aumentarEstadistica(self)})
	}
	 
	method pelear(enemigo) {
		item.ataques().danioQueProvoca(enemigo)
	}
	
	method agregarItem(nuevoItem) {    // deberia poder elegir el item que deja????
		if(items.size() >= 3){
			self.dejarItemDeMenorPoder()
			items.add(nuevoItem)
		} else{
			items.add(nuevoItem)
		}
	}
	
	method dejarItemDeMenorPoder(){
		items.remove(items.min({item => item.poder()}))
	}
}
*/