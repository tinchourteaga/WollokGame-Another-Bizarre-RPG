import wollok.game.*
import items.*
import personajes.*

class Enemigo {

	var vida = 500
	// var itemQueDropea = #{} // puede dropear pociones
	var velocidad // la velocidad podria servir para decir cada cuanto golpea a nuestro personaje	
	var property image

	method esEnemigo() = true
	
	method esAtravesable() = true
	
	method morir() {
		if (vida <= 0) {
			game.removeVisual(self)
		// game.addVisual(itemQueDropea)
		}
	}

	method atacar(personaje)


	method velocidad() = velocidad

}

class Troll inherits Enemigo {

	override method atacar(personaje) {
		personaje.disminuirVida(10 * velocidad)
	}

}

class Dragon inherits Enemigo {

	override method atacar(personaje) {
		personaje.disminuirVida(100)
	}

}

// TANTO EL MAGO COMO EL GATO PODRIAN MOVERSE ALEATORIAMENTE EN UN DETERMINADO ESPACIO, SI COLISIONA CON NOSOTROS (HAY QUE EVTARLO)
// NOS ROBA UN ITEM
object mago inherits Enemigo {

	override method velocidad() = 25

	override method image() = "mago.png"

	override method atacar(personaje) {
	// robarItemConMasPoder.ataque(personaje) // o podria robar alguna pocion
	}

}

object gato inherits Enemigo {

	var poderEspada = 60

	override method velocidad() = 50

	override method image() = "gato.png"

	override method atacar(personaje) {
		// robarItemEnMano.ataque(personaje)
		personaje.disminuirVida(2 * poderEspada)
	}

}

class Gigante inherits Enemigo {

	var peso = 1000

	override method atacar(personaje) {
		personaje.disminuirVida(peso / 8)
	}

}

class PerroDeTresCabezas inherits Enemigo {

	override method atacar(personaje) {
		personaje.disminuirVida(3 * velocidad)
	}

}

