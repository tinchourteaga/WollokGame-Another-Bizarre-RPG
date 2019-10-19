import wollok.game.*
import personajes.*
import enemigos.*
import ataques.*
// armas
class Arma {

	var property danio
	
	method image()
	
	method ataque(personaje)
	
	method aumentarEstadisticas(personaje)

	method esAgarrable() = true
	
	method esAtravesable() = true

}

class Espada inherits Arma {
	override method danio() = 50
	
	override method ataque(personaje) {
		personaje.disminuirVida(danio)
	}
	
	override method image() = "magmaSword.png"
	
	override method aumentarEstadisticas(personaje) { 
		personaje.velocidad(personaje.velocidad() * 2)
	}

}

class BastonMagico inherits Arma {
	override method danio() = 90
	
	override method image() = "" //Hay que buscar alguna imagen
	
	override method ataque(personaje) {
		personaje.disminuirVida(danio * 2)
	}
	
	override method aumentarEstadisticas(personaje) {
		personaje.aumentarVida(15)
	}
}
// pociones 
class Pocion {

	method esAtravesable() = true
	
	method esAgarrable() = true

    method image() 
    
	method efecto(personaje)
}

object pocionSalud inherits Pocion {
	
	override method image() = "pocionSalud.png"

	override method efecto(personaje) {
		var nuevaVida = personaje.vida() + personaje.vida() * 0.2
		personaje.vida(100.min(nuevaVida))
	}
}

object pocionMana inherits Pocion {

	override method image() = ""

	override method efecto(personaje) {
		personaje.mana(300.min(50))     // mana es un atributo de personaje? si lo es, hay que agregarlo
	}

}

object pocionVeneno inherits Pocion {

	override method image() = ""

	override method efecto(personaje) {
	// hace que los ataques envenenen al enemigo (pierda "x" vida por turno)
	}

}

object pocionDefensa inherits Pocion {

	override method image() = ""

	override method efecto(personaje) {
	// reduce el daño recibido 
	}

}

object pocionFuerza inherits Pocion {

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

