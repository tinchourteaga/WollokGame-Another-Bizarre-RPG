import wollok.game.*
import personajes.*
import enemigos.*

class Ataque {
	var property danio = 0
	
	method ataque(personaje)
}

object robarItemConMasPoder inherits Ataque {
	
	override method ataque(personajeAfectado) {
		personajeAfectado.items().remove(self.itemConMasPoder(personajeAfectado))
	}
	
	method itemConMasPoder(personaje) {
		return personaje.items().max({item => item.poder()})
	}
}

object robarItemEnMano inherits Ataque {
	
	override method ataque(personaje) {
		
		personaje.ponerItemSiguienteEnMano()	
	}
}