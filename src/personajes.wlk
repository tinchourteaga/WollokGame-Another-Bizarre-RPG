import wollok.game.*
import items.*
import nivel.*
import extras.*

class Personaje {
	var property vida = 500
    var itemEnMano 
    var items = []
	var killsCounter = 0
    var position = game.at(12, 4)
    
    method image()

    method position() = position

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
			itemEnMano = items.head() // Poner que se actualice la img cuando esten hechos los items
		} // else "inventario vacio"
	}

	method dejarItemEnMano() {
		items.remove(itemEnMano)
		game.removeVisual(itemEnMano) // Lo destruye, no lo dropea
	}

	method agarrarItem() {
		if (items.size() < 5) {
			if (!items.isEmpty()) {
				self.agregarAInventario()
			} 
			else {
				self.agregarAInventario()
				itemEnMano = items.head()
			}
		} else{
			game.say(self,"Inventario Lleno!")
		}	
	}

	method agregarAInventario() {
		var nuevoItem = game.colliders(self).head()
		items.add(nuevoItem)
		game.removeVisual(nuevoItem)
		game.addVisualIn(nuevoItem, game.at(0,0)) // Habria que ponerlo en la pocion de inventario que corresponda
	}

	method mejorarEstadisticas() {
		itemEnMano.aumentarEstadistica(self)
	}

	method matar(enemigo) {
		enemigo.morir()
		killsCounter++
	}
	
	method llevarItemEnMano() {            // para que muestre el item en el personaje y se mueva a la par
		itemEnMano.position(self.position())
	} 
	
	method disminuirVida(valorNuevo) {
		vida = vida - valorNuevo
	}
	
	method aumentarVida(valorNuevo) {
		vida = valorNuevo
	}
	
	method pelear(enemigo) {
		items.forEach({item => item.ataque(enemigo)})
	}
}

object scorpion inherits Personaje {
    var ataque = 80
    var velocidad = 30

	override method image() = "scorpion.png"
}

object gandalf inherits Personaje {
    var ataque = 120
    var velocidad = 15

	override method image() = "gandalf.png"

}
