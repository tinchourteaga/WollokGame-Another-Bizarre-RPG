import wollok.game.*
import personajes.*

class Muro {

	method esAtravesable() = false

}

class MuroVertical inherits Muro {

	method image() = "muro_achicado.png" // Hay que achicar la img

}

class MuroHorizontal inherits Muro {

	method image() = "muro_achicado.png" // Hay que achicar la img

}

class BloqueInventario {
	
	var property slotOcupado = false

	method image() = "minecraftSlot.png"
	
	method ocuparSlot() {
		slotOcupado = true
	}
	
	method liberarSlot() {
		slotOcupado = false
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

class Pinchos {

	var position

	method position() = position

	method image() = "Pinchos.png"

}

object fireBall {

	var property position = game.at(11, 11)

	method image() = "fireball.png"

	method esAtravesable() = false

	//method quemarPersonaje() 

	method moverFireball() {
		if (position.y() >= 9) {
			position = position.down(1)
		} else {
			position = game.at(11, 11)
		}
	}

}

object arrow {

	var property position = game.at(8, 8)

	method image() = "arrow.png"

	method esAtravesable() = false

	//method daniarPersonaje() = 

	method moverArrow(){
		if (position.y() <= 10) {
			position = position.up(1)
		} else {
			position = game.at(8, 8)
		}
	}

}

object spike {

	var property position = game.at(5, 8)

	method image() = "spike.png"

	method esAtravesable() = false

	//method daniarPersonaje() = 

	method moverSpike(){
		if (position.y() <= 10) {
			position = position.up(1)
		} else {
			position = game.at(5, 8)
		}
	}

}

object button {

	var estaEncendido = true

	method esAgarrable() = false

	method image() {
		return if (estaEncendido) "ButtonOn.png" else "ButtonOff.png"
	}

	method esAtravesable() = true

	method cambiarEncendido(cambioEncendido) {
		estaEncendido = cambioEncendido
	}

	method accionarBoton(personaje) {
		if (estaEncendido) {
			self.cambiarEncendido(false)
		} else {
			self.cambiarEncendido(true)
		}
	}

}

object escalera {

	method image() = "escaleras.png"

	method esAtravesable() = true

}

object scorpionSeleccion {
	
	method image() = "scorpionSeleccion.png"
	
	method position() = game.at(3,0)
}

object gandalfSeleccion {
	
	method image() = "gandalfSeleccion.png"
	
	method position() = game.at(18,0)
}

object seleccionPersonajeTextBox {
	
	method image() = "seleccionPersonajeText.png"
	
	method position() = game.at(10,10)
}

object gandalfTextBox {
	
	method image() = "gandalfText.png"
	
	method position() = game.at(14,6)
}

object scorpionTextBox {
	
	method image() = "scorpionText.png"
	
	method position() = game.at(7,6)
}









