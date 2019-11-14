import wollok.game.*
import personajes.*
import enemigos.*
import ataques.*

// armas
class Arma {

	method image()

	method ataque(owner, target)

	method efectoDelAtaque(efectoAtaque, owner, target) {
		if (!target.tieneStatusEffect()) {
			efectoAtaque.efecto(owner, target)
		}
	}

	method modificarStats(owner)

	method disminuirStats(owner)

	method esAgarrable() = true

	method esAtravesable() = true

	method usar(personaje) {
	}

}

class EspadaDeMagma inherits Arma { 
	
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

class Daga inherits Arma { 
	
	var efectoAtaque = envenenado
	var fuerza = 20
	var vida = 30

	override method image() = "daga.png"

	override method ataque(owner, target) {
		target.disminuirVida(fuerza + vida)
		self.efectoDelAtaque(efectoAtaque, owner, target)
	}

	override method modificarStats(owner) {
		owner.aumentarFuerza(fuerza)
		owner.aumentarVida(vida)
	}

	override method disminuirStats(owner) {
		owner.disminuirFuerza(fuerza)
		owner.disminuirVida(vida)
	}

}
class EspadaDiamante inherits Arma {

	var vida = 50
	var fuerza = 90

	override method image() = "espadaDiamante.png"

	override method ataque(owner, target) {
		target.disminuirVida(owner.vida() * 0.3)
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
class Espada inherits Arma {

	var fuerza = 20

	override method image() = "espadaDiamante.png"

	override method ataque(owner, target) {
		target.disminuirVida(owner.fuerza() * 0.1)
	}

	override method modificarStats(owner) { // Cuando se equipa el item en mano
		owner.aumentarFuerza(fuerza)
	}

	override method disminuirStats(owner) { // Cuando se desequipa el item en mano
		owner.disminuirFuerza(fuerza)
	}

}
class Kunai inherits Arma {

	var fuerza = 25

	override method image() = "espadaDiamante.png"

	override method ataque(owner, target) {
		target.disminuirVida(owner.fuerza())
	}

	override method modificarStats(owner) { // Cuando se equipa el item en mano
			owner.aumentarFuerza(fuerza)
	}

	override method disminuirStats(owner) { // Cuando se desequipa el item en mano
		owner.disminuirFuerza(fuerza)
	}

}

class Guantelete inherits Arma {

	var vida = 100
	const efectoAtaque = electrocutar

	override method image() = "guantelete.png"

	override method ataque(owner, target) {
		target.disminuirVida(owner.fuerza())
		self.efectoDelAtaque(efectoAtaque, owner, target)
	}

	override method modificarStats(owner) { // Cuando se equipa el item en mano
		owner.aumentarVida(vida)
	}

	override method disminuirStats(owner) { // Cuando se desequipa el item en mano
		owner.disminuirVida(vida)
	}

}

class MasterSword inherits Arma {

	var vida = 0
	var fuerza = 50

	override method image() = "masterSword.png"

	override method ataque(owner, target) {
		target.disminuirVida(owner.vida() * 0.5)
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

class EspadasDelCaos inherits Arma {

	var vida = 50
	var fuerza = 90
	const efectoAtaque = incinerar

	override method image() = "espadasDelCaos.png"

	override method ataque(owner, target) {
		target.disminuirVida(50)
		self.efectoDelAtaque(efectoAtaque, owner, target)
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

class EspadaAzul inherits Arma {

	var vida = 50
	var fuerza = 50
	
	const efectoAtaque = electrocutar

	override method image() = "espadaAzul.png"

	override method ataque(owner, target) {
		target.disminuirVida(owner.fuerza() * 0.5)
		self.efectoDelAtaque(efectoAtaque, owner, target)
	}

	override method modificarStats(owner) { // Cuando se equipa el item en mano
		owner.aumentarVida(vida)
		owner.aumentarVida(fuerza)
	}

	override method disminuirStats(owner) { // Cuando se desequipa el item en mano
		owner.disminuirVida(vida)
		owner.disminuirVida(fuerza)
	}

}
class BastonMagico inherits Arma { // TODO: Sigan este ejemplo para agregar ataques especiales a las armas (fijarse los ataques en Ataques.wlk)

	var vida = 150
	var efectoAtaque = electrocutar

	override method image() = "vara.png"

	override method ataque(owner, target) {
		target.disminuirVida(target.fuerza() / 3)
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

	override method ataque(owner, target) {
		owner.disminuirVida(owner.fuerza())
	}

	override method modificarStats(owner) {
		owner.aumentarFuerza(fuerza)
	}

	override method disminuirStats(owner) {
		owner.disminuirFuerza(fuerza)
	}

}

// pociones 
class Pocion {

	var position

	method esAtravesable() = true

	method esAgarrable() = true

	method image()

	method efecto(personaje)

	method disminuirStats(personaje) {
	}

	method modificarStats(personaje) {
	}

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

 * class PocionMana inherits Pocion {

 * 	override method image() = "pocionMana.png"

 * 	override method efecto(personaje) {
 * 		personaje.mana(300.min(50)) // mana es un atributo solo de gandalf
 * 	}

 * }

 * class PocionVeneno inherits Pocion {

 * 	override method image() = "pocionVeneno.png"

 * 	override method efecto(personaje) {
 * 	// hace que los ataques envenenen al enemigo (pierda "x" vida por turno)
 * 	}

 * }


 * class PocionDefensa inherits Pocion {

 * 	override method image() = ""

 * 	override method efecto(personaje) {
 * 	// reduce el daño recibido 
 * 	}

 * }

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

