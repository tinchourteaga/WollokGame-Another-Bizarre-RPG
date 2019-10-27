import wollok.game.*
import items.*
import nivel.*
import extras.*
import ataques.*

class Personaje {

	var vida = 1000
	var property fuerza = 10
	var property defendiendo = false
	var property statusEffect = ninguno
	var itemEnMano
	var property items = []
	var position = game.at(12, 4)

	method image()

	method position() = position

	method vida() = vida

	method moverse(nuevaPosicion, orientacion, personaje) {
		if (self.puedeMoverse(orientacion, personaje)) {
			position = nuevaPosicion
		} // else no se mueve
	}

	method puedeMoverse(orientacion, personaje) {
		return orientacion.posicionEnEsaDireccion(personaje).allElements().all({ objeto => objeto.esAtravesable() })
	}

	method ponerItemSiguienteEnMano() {
		if (!items.isEmpty()) {
			self.moverInventario()
			itemEnMano = items.head()
		} else {
			game.say(self, "Inventario Vacio!")
		}
	}

	method dejarItemEnMano() { // Lo destruye, no lo dropea
		self.ponerItemSiguienteEnMano()
		var item = items.last()
		var slot = game.colliders(item).head()
		slot.liberarSlot()
		items.remove(item)
		game.removeVisual(item)
	}

	method moverInventario() {
		var listaSlots = items.map({ item => game.colliders(item).head() })
		listaSlots.forEach({ slot => slot.liberarSlot()})
		items.forEach({ item => game.removeVisual(item)})
		items.remove(itemEnMano)
		items.add(itemEnMano)
		items.forEach({ item => self.posicionEnInventario(item, 0)})
	}

	method agarrarItem() {
		if (items.size() < 5 && game.colliders(self).head().esAgarrable()) {
			if (!items.isEmpty()) {
				self.agregarAInventario()
			} else {
				self.agregarAInventario()
				itemEnMano = items.head()
			}
		} else {
			game.say(self, "Inventario Lleno!")
		}
	}

	method agregarAInventario() {
		var nuevoItem = game.colliders(self).head()
		items.add(nuevoItem)
		game.removeVisual(nuevoItem)
		self.posicionEnInventario(nuevoItem, 0)
		nuevoItem.efecto(self)
	}

	method posicionEnInventario(nuevoItem, posicionEnX) {
		var slot = game.getObjectsIn(game.at(posicionEnX, 0)).head()
		if (!slot.slotOcupado()) {
			game.addVisualIn(nuevoItem, game.at(posicionEnX, 0))
			slot.ocuparSlot()
		} else {
			var nuevaPosicionEnX = posicionEnX + 1
			self.posicionEnInventario(nuevoItem, nuevaPosicionEnX)
		}
	}

	method morir() = vida == 0
	
	method matar(enemigo) {
		enemigo.morir()
		killsCounter++
	}

	method llevarItemEnMano() { // para que muestre el item en el personaje y se mueva a la par
		itemEnMano.position(self.position())
	}

	method disminuirVida(valor) {
		vida = 0.max(vida - valor)
	}

	method aumentarVida(valor) {
		vida = vida + valor
	}
	
	method aumentarFuerza(valor) {
		fuerza = fuerza + valor
	}
	
	method disminuirFuerza(valor) {
		fuerza = fuerza - valor
	}

	method pelear(enemigo) {
		if (enemigo.esEnemigo()) {
			interfazPelea.iniciar(self,enemigo)
		// aca triggereamos la interfaz de pelea
		}
	}
	 
	method atacar(enemigo) {
		self.defendiendo(false)
		self.sufrirStatusEffect()
		ataqueBasico.efecto(self,enemigo)
		enemigo.ocuparTurno(self)
		//game.addVisual(attackHit) La idea de esto era visualizar el hit del ataque
		//game.onTick(1500, "removerAtaque", { => game.removeVisual(attackHit) })

	}
	 
	method defenderse(enemigo) {
		self.sufrirStatusEffect()
		self.defendiendo(true)
		enemigo.ocuparTurno(self)
	}
	/* 
	method ataqueEspecial(enemigo) { // aca va el efecto del item en mano
		self.defendiendo(false)
		self.sufrirStatusEffect()
		itemEnMano.ataque(enemigo)
		enemigo.ocuparTurno(self)
	}
	*/
	method sufrirStatusEffect() {
		statusEffect.efectoPorTurno(self)
	}


}


object scorpion inherits Personaje {

	override method image() {
		return if(game.hasVisual(fondo)) "scorpionPelea.png" else "scorpion.png"
	} 

}

object gandalf inherits Personaje {

	// var ataque = 120 esto estaba en la rama, probablemente haya que cambiar algo
	var property danio = 30
	var property mana = 500 // no coincide con los ataques del enemigo porque los metodos atacar esperan el mensaje vida() no mana()

	override method image() {
		return if(game.hasVisual(fondo)) "gandalfPelea.png" else "gandalf.png"
	} 

	method aumentarDanio(valor) {
		danio = danio + valor
	}

}

object arriba {

	method posicionEnEsaDireccion(personaje) = personaje.position().up(1)

}

object abajo {

	method posicionEnEsaDireccion(personaje) = personaje.position().down(1)

}

object derecha {

	method posicionEnEsaDireccion(personaje) = personaje.position().right(1)

}

object izquierda {

	method posicionEnEsaDireccion(personaje) = personaje.position().left(1)

}

