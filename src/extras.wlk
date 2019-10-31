import wollok.game.*
import personajes.*

// Elementos para el diseño del nivel
class Extra {
	var property position

	method esAtravesable() = true

	method esAgarrable() = false

	method esEnemigo() = false

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

object trampaPinchos1 inherits TrampaPinchos {

}

object trampaPinchos2 inherits TrampaPinchos {

}

object trampaPinchos3 inherits TrampaPinchos {

}

object trampaPinchos4 inherits TrampaPinchos {

}

class Muro {

	method esAtravesable() = false

}

class MuroVertical inherits Muro {

	method image() = "muro.png"

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

// Obstaculos

class FireBall inherits Extra {
    const posicionInicial
    var property velocidad

	method image() = "fireball.png"

	method efecto(personaje) {
		personaje.disminuirVida(10)
	}

	method moverFireBall() {
		if (position.y() >= 9) {
			position = position.down(1)
		} else {
			position = posicionInicial
		}
	}

}

class Arrow inherits Extra {
    const posicionInicial
    var property velocidad

	method image() = "arrow.png"

	method efecto(personaje) {
		personaje.disminuirVida(20)
	}

	method moverArrow() {
		if (position.y() <= 10) {
			position = position.up(1)
		} else {
			position = posicionInicial
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

// Declaracion de FireBalss y Arrows

var fireBall1 = new FireBall(position = game.at(11,11), posicionInicial = game.at(11,11), velocidad = 1250)
var fireBall2 = new FireBall(position = game.at(12,11), posicionInicial = game.at(12,11), velocidad = 1000)
var fireBall3 = new FireBall(position = game.at(13, 11), posicionInicial = game.at(13,11), velocidad = 800)
var arrow1 = new Arrow(position = game.at(7,8), posicionInicial = game.at(7,8), velocidad = 1250)
var arrow2 = new Arrow(position = game.at(8,8), posicionInicial = game.at(8,8), velocidad = 1000)
var arrow3 = new Arrow(position = game.at(9,8), posicionInicial = game.at(9,8), velocidad = 800)

var fireBalls = [fireBall1,fireBall2,fireBall3]
var arrows = [arrow1,arrow2,arrow3]

// Declaracion de elementos para el disenio del nivel 

const botonTrampa = new BotonTrampa(puertaQueAcciona = puerta1, position = game.at(7,2))
const boton1 = new Boton(puertaQueAcciona = puerta2, position = game.at(1,8))
const boton2 = new Boton(puertaQueAcciona = puerta3, position = game.at(16,11))
const boton3 = new Boton(puertaQueAcciona = puerta4, position = game.at(5,3))
const puerta1 = new PuertaHorizontal(position = game.at(1, 5))
const puerta4 = new PuertaHorizontal(position = game.at(16, 7))
const puerta3 = new PuertaVertical(position = game.at(15, 9))
const puerta2 = new PuertaVertical(position = game.at(17, 2))

var puertas = [puerta1,puerta2,puerta3,puerta4]
var botones = [botonTrampa,boton1,boton2,boton3]