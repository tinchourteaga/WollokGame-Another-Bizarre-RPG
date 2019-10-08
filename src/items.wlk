import wollok.game.*
import personajes.*
import enemigos.*
import ataques.*

class Arma { // Ver a futuro si realmente quiero una super clase Arma
	
}

class Espada {
	var position = game.at(3,3)
	
	method position() = position
	
	method image()
} 

class Pocion {
	
}



object magmaSword inherits Espada {
	
	override method image() = "magmaSword.png"
}
