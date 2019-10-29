import wollok.game.*
import personajes.*

///////////////////////////////////////////////

const botonTrampa = new BotonTrampa(puertaQueAcciona = puerta1)
const boton1 = new Boton(puertaQueAcciona = puerta2)
const boton2 = new Boton(puertaQueAcciona = puerta3)
const boton3 = new Boton(puertaQueAcciona = puerta4)

const puerta1 = new PuertaHorizontal()
const puerta4 = new PuertaHorizontal()
const puerta3 = new PuertaVertical()
const puerta2 = new PuertaVertical()

const trampaPinchos1 = new TrampaPinchos()
const trampaPinchos2 = new TrampaPinchos()
const trampaPinchos3 = new TrampaPinchos()
const trampaPinchos4 = new TrampaPinchos()

///////////////////////////////////////////////

class Muro {

	method esAtravesable() = false

}

class MuroVertical inherits Muro {

	method image() = "muro.png" // Hay que achicar la img

}

class Caliz inherits Muro {

	method image() = "caliz_de_fuego.png"

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

class Extra {

	method esAtravesable() = true

	method esAgarrable() = false

	method esEnemigo() = false

}

object fireBall inherits Extra {

	var property position = game.at(11, 11)

	method image() = "fireball.png"

	method efecto(personaje) {
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

	method efecto(personaje) {
		personaje.disminuirVida(20)
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

	method efecto(personaje) {
		personaje.disminuirVida(60)
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

class BotonTrampa inherits Boton {

	var trampasQueActiva = [ trampaPinchos1, trampaPinchos2, trampaPinchos3, trampaPinchos4 ]

	override method accionarBoton(personaje) {
		if (estaEncendido) {
			trampasQueActiva.forEach({ trampa => trampa.armarODesarmarTrampa()})
			super(estaEncendido)
		} else {
			trampasQueActiva.forEach({ trampa => trampa.armarODesarmarTrampa()})
			super(estaEncendido)
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

// SELECCION DE PERSONAJE

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

// INTERFAZ PELEA

object fondo {
	
	method image() = "fondoInterfazPelea.png"
}

object textAtacar {
	
	var property position = game.at(2,2)
	
	method image() = "textAtacar.png"
	 
}

object textDefender {
	
	var property position = game.at(8,2)
	
	method image() = "textDefender.png"
}

object textEspecial {
	
	var property position = game.at(14,2)
	
	method image() = "textEspecial.png"
}

object textCambiarArma {
	
	var property position = game.at(20,2)
	
	method image() = "textCambiarArma.png"
}

object attackHit {
	
	var property position = game.at(18,6)
	
	method image() = "attackHit.png"
}

// PANTALLA GAMEOVER

object fondoGameOver {
	
	method image() = "fondoGameOver.jpg"
}

// PANTALLA VICTORIA

object fondoVictoria {
	
	method image() = "fondoVictoria.jpg"
}

object poro {
	
	method image() = "poro.png"
}






