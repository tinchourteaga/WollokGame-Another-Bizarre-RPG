import wollok.game.*
import personajes.*
import enemigos.*
// los ataques pueden ser objetos que provoquen distinto danio y asignarles distintos a los personajes y/o enemigos
object robarItemConMasPoder {
	
	method danioQueProvoca(personajeAfectado,personajeBeneficiado) {
		personajeAfectado.items().remove(self.itemConMasPoder(personajeAfectado))
		personajeBeneficiado.items().add(self.itemConMasPoder(personajeAfectado))
	}
	
	method itemConMasPoder(personaje) {
		return personaje.items().max({item => item.poder()})
	}
}

object ataqueDeEspada() { // cambiar nombre dsp pq no se me ocurre nada :)
	const danio = 15
	
	method danioQueProvoca(personaje) {
		personaje.vida() -= danio
	}
	
}