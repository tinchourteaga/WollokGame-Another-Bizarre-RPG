import wollok.game.*
import personajes.*
import enemigos.*
import ataques.*

// armas
class Arma {

	var property danio

	method image()

	method ataque(personaje)

	method efecto(personaje)

	method esAgarrable() = true

	method esAtravesable() = true

	method esEnemigo() = false

}

class Espada inherits Arma {

	override method ataque(personaje) {
		personaje.disminuirVida(100)
	}

	override method image() = "magmaSword.png"

	override method efecto(personaje) {
	}

}

class EspadaDiamante inherits Arma {

	override method image() = "espadaDiamante.png"

	override method ataque(personaje) {
		personaje.disminuirVida(personaje.vida() * 0.3)
	}

	override method efecto(personaje) {
		personaje.aumentarVida(50)
		personaje.aumentarFuerza(90)
	}

}

class BastonMagico inherits Arma {

	override method image() = "vara.png"

	override method ataque(personaje) {
		personaje.disminuirVida(personaje.vida()/3)
	}

	override method efecto(personaje) {
		personaje.aumentarVida(150)
	}

}

class Arco inherits Arma {

	override method image() = "arco.png"

	override method ataque(personaje) {
		personaje.disminuirVida(personaje.danio())
	}

	override method efecto(personaje) {
		personaje.aumentarDanio(5)
	}

}

// pociones 
class Pocion {

	method esAtravesable() = true

	method esAgarrable() = true

	method esEnemigo() = false

	method image()

	method efecto(personaje)

}

class PocionSalud inherits Pocion {

	override method image() = "pocionSalud.png"

	override method efecto(personaje) {
		var valorCuracion = personaje.vida() * 0.2
		personaje.aumentarVida(valorCuracion)
	}

}

class PocionMana inherits Pocion {

	override method image() = "pocionMana.png"

	override method efecto(personaje) {
		personaje.mana(300.min(50)) // mana es un atributo solo de gandalf
	}

}

class PocionVeneno inherits Pocion {

	override method image() = "pocionVeneno.png"

	override method efecto(personaje) {
	// hace que los ataques envenenen al enemigo (pierda "x" vida por turno)
	}

}

class PocionDefensa inherits Pocion {

	override method image() = ""

	override method efecto(personaje) {
	// reduce el daño recibido 
	}

}

class PocionFuerza inherits Pocion {

	override method image() = ""

	override method efecto(personaje) {
	// aumenta el ataque 
	}

}

object pocionInmortalidad inherits Pocion {

	override method image() = ""

	override method efecto(personaje) {
		personaje.vida(10000)
	}

}

