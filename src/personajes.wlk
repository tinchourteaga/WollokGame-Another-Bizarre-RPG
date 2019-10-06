import wollok.game.*
import items.*
import nivel.*

object scorpion { 
	var ataque = 100
	var vida = 500
	var velocidad = 60
	var items = #{}
	var position = game.at(5,-2) // Solo en este caso para que empiece en cierta parte del mapa
	
	method position() = position
	
	method modificarPosicion(nuevaPosicion) = (position = nuevaPosicion)
	
	method image() = "scorpion2.png"
	
	method dignidad() {                          // la dignidad se la da el poder de los items
		return items.sum({item => item.poder()})
	}
	
	method moverse(nuevaPosicion) { // De esta forma no se va mas alla de los bordes de la ventana
		if(nuevaPosicion.x().between(-1,10) && nuevaPosicion.y().between(-2,9)){
			position = nuevaPosicion	
		}	
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