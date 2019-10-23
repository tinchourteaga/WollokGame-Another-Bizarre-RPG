import wollok.game.*
import items.*
import personajes.*

class Enemigo { 
	var x
	var y
	var vida
	var velocidad
	var property image

    method position() = game.at(x,y)

	method esEnemigo() = true
	
	method esAtravesable() = true
	
	method morir() {
		if (vida <= 0) {
			game.removeVisual(self)
		}
	}
	
	method cambiarPosicionEnX(posicion) {
		x = posicion
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
		personaje.disminuirVida(300)
	}
}

// TANTO EL MAGO COMO EL GATO PODRIAN MOVERSE ALEATORIAMENTE EN UN DETERMINADO ESPACIO, SI COLISIONA CON NOSOTROS (HAY QUE EVTARLO)
// NOS ROBA UN ITEM
class Mago inherits Enemigo {

	override method atacar(personaje) {
	// robarItemConMasPoder.ataque(personaje)
	}
}

class Gato inherits Enemigo {

	var poderEspada = 70

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
		personaje.disminuirVida(4 * velocidad)
	}
}

