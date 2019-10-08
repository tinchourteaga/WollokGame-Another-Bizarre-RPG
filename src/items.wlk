import wollok.game.*
import personajes.*
import enemigos.*
import ataques.*

class Arma {
	var atravesable = true

	method esAtravesable() = atravesable
}

class Espada inherits Arma {
	var position = game.at(3,3)
	
	method position() = position
	
	method image()
} 

class Pocion {
	
}



object magmaSword inherits Espada {
	
	override method image() = "magmaSword.png"
}
