import wollok.game.*
import personajes.*

class Muro {

	method esAtravesable() = false

}

class MuroVertical inherits Muro {

	method image() = "muro.png" // Hay que achicar la img

}

class Caliz inherits Muro {

	method image() = "caliz_de_fuego.png"

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

	method moverArrow() {
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

	method moverSpike() {
		if (position.y() <= 10) {
			position = position.up(1)
		} else {
			position = game.at(5, 8)
		}
	}

}

class Boton inherits Extra {

	var estaEncendido = false
	var puertaQueAcciona // cuando creamos el boton le ponemos que puerta maneja

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

object botonTrampa inherits Boton {

	var trampasQueActiva = [ trampaPinchos1, trampaPinchos2, trampaPinchos3, trampaPinchos4 ]

	override method accionarBoton(personaje) {
		if (estaEncendido) {
			self.cambiarEncendido(false)
			puerta1.abrirOCerrarPuerta()
			trampasQueActiva.forEach({ trampa => trampa.armarODesarmarTrampa()})
		} else {
			self.cambiarEncendido(true)
			puerta1.abrirOCerrarPuerta()
			trampasQueActiva.forEach({ trampa => trampa.armarODesarmarTrampa()})
		}
	}

}

class Puerta inherits Extra {

	var cerrada = true

	override method esAtravesable() {
		return !cerrada
	}

	method cambiarEstadoPuerta(estado) {
		cerrada = estado
	}

	method abrirOCerrarPuerta() {
		if (cerrada) {
			self.cambiarEstadoPuerta(false)
		} else {
			self.cambiarEstadoPuerta(true)
		}
	}

}

class PuertaBoss inherits Puerta {
	
	method abreteSesamo() {
		cerrada = false
	}
}

object puertaIzquierdaBoss inherits PuertaBoss {
	
	method image() {
		return if (cerrada) "puertaCerradaCortadaIzquierda.png" else "puertaCortadaAbiertaIzquierda.png"
	}
}

object puertaDerechaBoss inherits PuertaBoss {

	method image() {
		return if (cerrada) "puertaCerradaCortadaDerecha.png" else "puertaCortadaAbiertaDerecha.png"
	}
}

class PuertaHorizontal inherits Puerta {

	method image() {
		return if (cerrada) "puertaCerrada.png" else "puertaAbierta.png"
	}

}

class PuertaVertical inherits Puerta {

	method image() {
		return if (cerrada) "puertaCerradaVertical.png" else "puertaAbiertaVertical.png"
	}

}

// No se si es la mejor manera pero...funciona
object puerta1 inherits PuertaHorizontal {

}

object puerta2 inherits PuertaVertical {

}

object puerta3 inherits PuertaVertical {

}

object puerta4 inherits PuertaHorizontal {

}

object puertaBoss inherits PuertaHorizontal {

} // que se abre cuando todos los botones estan activados

class TrampaPinchos inherits Extra {

	var armada = false

	method image() {
		return if (armada) "trampaConPinchos.png" else "trampaSinPinchos.png"
	}

	override method esAtravesable() {
		return !armada
	}

	method cambiarEstadoTrampa(estado) {
		armada = estado
	}

	method armarODesarmarTrampa() {
		if (armada) {
			self.cambiarEstadoTrampa(false)
		} else {
			self.cambiarEstadoTrampa(true)
		}
	}

}

object trampaPinchos1 inherits TrampaPinchos {

}

object trampaPinchos2 inherits TrampaPinchos {

}

object trampaPinchos3 inherits TrampaPinchos {

}

object trampaPinchos4 inherits TrampaPinchos {

}

object scorpionSeleccion {

	method image() = "scorpionSeleccion.png"

	method position() = game.at(3, 0)

}

object gandalfSeleccion {

	method image() = "gandalfSeleccion.png"

	method position() = game.at(18, 0)

}

object seleccionPersonajeTextBox {

	method image() = "seleccionPersonajeText.png"

	method position() = game.at(10, 10)

}

object gandalfTextBox {

	method image() = "gandalfText.png"

	method position() = game.at(14, 6)

}

object scorpionTextBox {

	method image() = "scorpionText.png"

	method position() = game.at(7, 6)

}

object guardarNivel {
	
}
