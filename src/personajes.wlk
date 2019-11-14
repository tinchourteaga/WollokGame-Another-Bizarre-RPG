import wollok.game.*
import items.*
import nivel.*
import extras.*
import ataques.*

class Personaje {

	var vidaMax = 5000 // valor fijo de vida max (no se modifica, solo con la pocion de inmortalidad)
	var vida = 5000
	var property fuerza = 1000
	var property defendiendo = false
	var property statusEffect = ninguno
	var property itemEnMano
	var property items = []
	var property position = game.at(12, 2)

	method vida() = vida
	
	method agregarItemALaLista(item) { // este metodo me sirve para los tests
		items.add(item)
	}

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
			var itemEnManoAnterior = items.last()
			itemEnManoAnterior.disminuirStats(self)
			itemEnMano = items.head()
			itemEnMano.modificarStats(self)
		} else {
			game.say(self, "Inventario Vacio!")
		}
	}

	method dejarItemEnMano() { // Lo destruye, no lo dropea
		self.ponerItemSiguienteEnMano()
		var item = items.last()
		var slot = game.colliders(item).head()
		slot.liberarSlot()
		if(items.size() == 1) item.disminuirStats(self)
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
				itemEnMano.modificarStats(self)
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

	method disminuirVida(valor) {
		vida = 0.max(vida - valor)
	}

	method aumentarVida(valor) {
		vida = vidaMax.min(vida + valor)
	}
	
	method aumentarFuerza(valor) {
		fuerza = fuerza + valor
	}
	
	method disminuirFuerza(valor) {
		fuerza = 0.max(fuerza - valor)
	}
	 
	method atacar(enemigo) {
		self.defendiendo(false)
		self.sufrirStatusEffect()
		ataqueBasico.efecto(self,enemigo)
		enemigo.ocuparTurno(self)
		enemigo.posicionAttackHit()
		game.onTick(600, "removerAtaque", { => if(game.hasVisual(attackHit)) game.removeVisual(attackHit) })

	}
	 
	method defenderse(enemigo) {
		self.sufrirStatusEffect()
		self.defendiendo(true)
		enemigo.ocuparTurno(self)
	}
	 
	method ataqueEspecial(enemigo) { // aca va el efecto del item en mano
		self.defendiendo(false)
		self.sufrirStatusEffect()
		itemEnMano.ataque(self, enemigo)
		enemigo.ocuparTurno(self)
	}
	
	method cambiarArma() {
		if(items.size() > 1) {
			var armaActual = items.head()
			items.remove(armaActual)
			items.add(armaActual)
			itemEnMano = items.head()	
		} else game.say(self, "Solo tenes un arma")
		
	}
	
	method sufrirStatusEffect() {
		statusEffect.efectoPorTurno(self)
	}


}

//TODO: Agregar stats distintos a ambos que sean acordes. Que no maten ni mueran de un golpe 
//(hagamos que gandalf no tenga mana porque hay que modificar varias cosas)

object scorpion inherits Personaje {

	method image() {
		return if(game.hasVisual(fondo)) "scorpionPelea.png" else "scorpion.png"
	} 

}

object gandalf inherits Personaje {

	method image() {
		return if(game.hasVisual(fondo)) "gandalfPelea.png" else "gandalf.png"
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