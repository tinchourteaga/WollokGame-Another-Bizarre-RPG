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
	
	method image() = "minecraftSlot.png"
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

object button {

	var estaEncendido = true

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

