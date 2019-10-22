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
			self.moverInventario()
			itemEnMano = items.head() 
		} else{
			game.say(self,"Inventario Vacio!")
		}
	}

	method dejarItemEnMano() { // Lo destruye, no lo dropea
		self.ponerItemSiguienteEnMano()
		var item = items.last()
		items.remove(item)
		game.removeVisual(item)
		
	}
	
	method moverInventario() {
		var listaSlots = items.map({ item => game.colliders(item).head() })
			listaSlots.forEach({ slot => slot.liberarSlot() })
			items.forEach({ item => game.removeVisual(item) })
			items.remove(itemEnMano)
			items.add(itemEnMano)
			items.forEach({ item => self.posicionEnInventario(item,0) })
	}

	method agarrarItem() {
		if (items.size() < 5 && game.colliders(self).head().esAgarrable()) {
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
		self.posicionEnInventario(nuevoItem, 0)
	}
	
	method posicionEnInventario(nuevoItem, posicionEnX) {
		var slot = game.getObjectsIn(game.at(posicionEnX,0)).head()
		
		if(!slot.slotOcupado()) {
			game.addVisualIn(nuevoItem, game.at(posicionEnX,0))
			slot.ocuparSlot()
		} else {
			var nuevaPosicionEnX = posicionEnX + 1
			self.posicionEnInventario(nuevoItem, nuevaPosicionEnX) //si explota todo a la mierda es por la recursividad (pero no lo hizo)
		}
		
	}
	
	method morir(){
		
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
