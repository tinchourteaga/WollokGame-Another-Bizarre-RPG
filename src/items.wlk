import wollok.game.*
import personajes.*
import enemigos.*
import ataques.*

class Arma {
	method esAgarrable() = true
	
	method esAtravesable() = true
}

class Espada inherits Arma {
	var position = game.at(3,3)
	
	method position() = position
	
	method image()
}

class Item {
	
	method esAtravesable() = true
	
	method esAgarrable() = true
} 

class PocionSalud inherits Item {

	method image() = "pocionSalud.png"

	method efecto(personaje) {
		var nuevaVida = personaje.vida() + personaje.vida() * 0.2
		personaje.vida(100.min(nuevaVida))
	}

}

class PocionMana inherits Item  {

	method image() = ""

	method efecto(personaje) {
		personaje.mana(300.min(50))
	}

}

class PocionVeneno inherits Item  {

	method image() = ""

	method efecto(personaje) {
	// hace que los ataques envenenen al enemigo (pierda "x" vida por turno)
	}

}

class PocionDefensa inherits Item  {

	method image() = ""

	method efecto(personaje) {
	// reduce el daño recibido 
	}

}

class PocionFuerza inherits Item  {

	method image() = ""

	method efecto(personaje) {
	// aumenta el ataque 
	}

}

class PocionInmortalidad inherits Item  {

	method image() = ""

	method efecto(personaje) {
		personaje.vida(0)
	}

}

