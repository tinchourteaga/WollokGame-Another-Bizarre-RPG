import wollok.game.*
import personajes.*

class Muro {

	var atravesable = false

	method esAtravesable() = atravesable

	method image()

}

class MuroVertical inherits Muro {

	override method image() = "muroVertical.png" // Hay que achicar la img

}

class MuroHorizontal inherits Muro {

	override method image() = "muroHorizontalResized.png" // Hay que achicar la img

}

object arriba {

	method posicionEnEsaDireccion() = scorpion.position().up(1)

}

object abajo {

	method posicionEnEsaDireccion() = scorpion.position().down(1)

}

object derecha {

	method posicionEnEsaDireccion() = scorpion.position().right(1)

}

object izquierda {

	method posicionEnEsaDireccion() = scorpion.position().left(1)

}

class Pinchos {
	var position
	
	method position() = position
	
	method image() = "Pinchos.png"
}

object button {
	var estaEncendido = true
	const position = game.at(9,7)
	
	method image() {
		return if(estaEncendido) "ButtonOn.png" else "ButtonOff.png"
	}
	
	method esAtravesable() = true
	
	method position() = position
	
	method cambiarEncendido(cambioEncendido) { estaEncendido = cambioEncendido }

	method accionarBoton(personaje) {
		if(estaEncendido) {
			self.cambiarEncendido(false)
		} else{
		    self.cambiarEncendido(true)
		}
	}

}
