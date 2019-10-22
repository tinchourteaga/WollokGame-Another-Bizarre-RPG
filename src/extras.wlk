import wollok.game.*
import personajes.*

class Muro {

	method esAtravesable() = false

}

class MuroVertical inherits Muro {

	method image() = "muro.png" // Hay que achicar la img

}

class MuroHorizontal inherits Muro {

	method image() = "muro.png" // Hay que achicar la img

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

class Extra {
	
	method esAtravesable() = true

	method esAgarrable() = false
	
	method esEnemigo() = false
}

class Pinchos inherits Extra {

	var position

	method position() = position

	method image() = "Pinchos.png"

}

object fireBall inherits Extra {

	var property position = game.at(11, 11)

	method image() = "fireball.png"

	method daniarPersonaje(personaje) {
		personaje.disminuirVida(10)
	}  

	method moverFireball() {
		if (position.y() >= 9) {
			position = position.down(1)
		} else {
			position = game.at(11, 11)
		}
	}

}

object arrow inherits Extra {

	var property position = game.at(8, 8)

	method image() = "arrow.png"

	method daniarPersonaje(personaje) {
		personaje.disminuirVida(10)
	} 

	method moverArrow(){
		if (position.y() <= 10) {
			position = position.up(1)
		} else {
			position = game.at(8, 8)
		}
	}

}

object spike inherits Extra {

	var property position = game.at(5, 8)

	method image() = "spike.png"

	method daniarPersonaje(personaje) {
		personaje.disminuirVida(10)
	} 

	method moverSpike(){
		if (position.y() <= 10) {
			position = position.up(1)
		} else {
			position = game.at(5, 8)
		}
	}

}

object escalera inherits Extra {

	method image() = "escaleras.png"
}

class Boton inherits Extra {

	var estaEncendido = false
	var puertaQueAcciona //cuando creamos el boton le ponemos que puerta maneja

	method image() {
		return if (estaEncendido) "ButtonOn.png" else "ButtonOff.png"
	}

	method cambiarEncendido(cambioEncendido) {
		estaEncendido = cambioEncendido
	}

	method accionarBoton(personaje) {
		if (estaEncendido) {
			self.cambiarEncendido(false)
			puertaQueAcciona.abrirOCerrarPuerta()
		} else {
			self.cambiarEncendido(true)
			puertaQueAcciona.abrirOCerrarPuerta()
		}
	}

}

class Puerta inherits Extra {
	
	var cerrada = true
	
	method image() {
		return if (cerrada) "puertaCerrada.png" else "puertaAbierta.png"
	}
	
	override method esAtravesable() {
		return !cerrada
	}
	
	method cambiarEstadoPuerta(estado) {
		cerrada = estado
	}
	
	method abrirOCerrarPuerta() {
		if(cerrada) {
			self.cambiarEstadoPuerta(false)
		} else {
			self.cambiarEstadoPuerta(true)
		}
	}
}

// No se si es la mejor manera pero...funciona
object puerta1 inherits Puerta {}
object puerta2 inherits Puerta {}
object puerta3 inherits Puerta {}
object puerta4 inherits Puerta {}
object puerta5 inherits Puerta {}
object puerta6 inherits Puerta {}
//object puertaBoss (que se abre cuando todos los botones estan activados)


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









