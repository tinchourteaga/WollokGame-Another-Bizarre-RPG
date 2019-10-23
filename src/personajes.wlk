import wollok.game.*
import items.*
import nivel.*
import extras.*

class Personaje {
	var vida = 1000
    var itemEnMano 
    var items = []
	var property killsCounter = 0
    var position = game.at(12,4)
    
    method image()
    
    method vida() = vida
    	
	method disminuirVida(valor) {
		vida = 0.max(vida - valor)
	}
	
	method aumentarVida(valor) {
		vida = 100.min(vida + valor)
	}

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
	
	method morir()

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

	method pelear(enemigo) {
		if(enemigo.esEnemigo()) {
			game.say(self, "Estoy colisionando con un enemigo")
			// aca triggereamos la interfaz de pelea
		}
		
	}
}

object scorpion inherits Personaje {
    var ataque = 80
    var velocidad = 30

	override method image() = "scorpion.png"
	
	override method morir() = vida == 0 
}

object gandalf inherits Personaje {
    var ataque = 120
    var velocidad = 15
    var mana = 500 // no coincide con los ataques del enemigo porque los metodos atacar esperan el mensaje vida() no mana()

	override method image() = "gandalf.png"
    
    override method morir() = mana == 0 
}
