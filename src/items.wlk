import wollok.game.*
import personajes.*
import enemigos.*
import ataques.*

class Arma {
	const property esUnArma = true // creo esta variable aca y en pociones para el ataque robarItemConMasFuerza

	method image()

	method ataque(owner, target)
	
	method efectoDelAtaque(efectoAtaque, owner, target) {
		if(!target.tieneStatusEffect()) {
			efectoAtaque.efecto(owner, target)
		}
	}

	method modificarStats(owner)
	
	method disminuirStats(owner)

	method esAgarrable() = true

	method esAtravesable() = true
	
	method usar(personaje) {}

}

class EspadaDeMagma inherits Arma { // Para evitar repeticion de codigo habria que hacer una clase Arma con Efecto y otra Sin efecto
									// Pero no tengo tiempo ni ganas
	var efectoAtaque = incinerar
	var fuerza = 60
	
	override method image() = "magmaSword.png"
	
	override method ataque(owner, target) {
		target.disminuirVida(100)
		self.efectoDelAtaque(efectoAtaque, owner, target)
	}
	
	override method modificarStats(owner) {
		owner.aumentarFuerza(fuerza)
	}
	
	override method disminuirStats(owner) { 
		owner.disminuirFuerza(fuerza)
	}
	

}

class EspadaDiamante inherits Arma {

	var vida = 50
    var fuerza = 90

	override method image() = "espadaDiamante.png"

	override method ataque(owner, target) {
		target.disminuirVida(target.vida() * 0.3)
	}

	override method modificarStats(owner) { // Cuando se equipa el item en mano
		owner.aumentarVida(vida)
		owner.aumentarFuerza(fuerza)
	}
	
	override method disminuirStats(owner) { // Cuando se desequipa el item en mano
		owner.disminuirVida(vida)
		owner.disminuirFuerza(fuerza)
	}

}

class BastonMagico inherits Arma { // TODO: Sigan este ejemplo para agregar ataques especiales a las armas (fijarse los ataques en Ataques.wlk)

	var vida = 150
	var efectoAtaque = electrocutar
	var fuerza = 110

	override method image() = "vara.png"

	override method ataque(owner,target) {
		target.disminuirVida(target.vida()/3)
		self.efectoDelAtaque(efectoAtaque, owner, target)
	}

	override method modificarStats(owner) {
		owner.aumentarVida(vida)
	}
	
	override method disminuirStats(owner) {
		owner.disminuirVida(vida)
	}

}

class Arco inherits Arma {

	var fuerza = 50

	override method image() = "arco.png"

	override method ataque(owner,target) {
		owner.disminuirVida(owner.fuerza())
	}

	override method modificarStats(owner) {
		owner.aumentarFuerza(fuerza)
	}
	
	override method disminuirStats(owner) {
		owner.disminuirFuerza(fuerza)
	}

}

// -------------------------------------------------------------------------------------------------------

class Pocion {
	var position
	const property esUnArma = false

	method esAtravesable() = true

	method esAgarrable() = true

	method image()

	method efecto(personaje)
	
	method disminuirStats(personaje) {}
	
	method modificarStats(personaje) {}
	
	method usar(personaje) {
		self.efecto(personaje)
		personaje.dejarItemEnMano()
	}

}

class PocionSalud inherits Pocion {

	override method image() = "pocionSalud.png"

	override method efecto(personaje) {
		var valorCuracion = personaje.vida() * 0.2
		personaje.aumentarVida(valorCuracion)
	}

}

/* Vamos a omitirlas porque no se llega

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

*/

class PocionFuerza inherits Pocion {

	override method image() = "pocionFuerza.png"

	override method efecto(personaje) {
		personaje.aumentarFuerza(100)
	}

}

object pocionInmortalidad inherits Pocion {

	override method image() = "pocionInmortalidad.png"

	override method efecto(personaje) {
		personaje.vidaMax(9999)
		personaje.vida(9999)
		
	}

}
