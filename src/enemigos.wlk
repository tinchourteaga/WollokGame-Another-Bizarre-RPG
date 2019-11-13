import wollok.game.*
import items.*
import personajes.*
import ataques.*
import extras.*
import nivel.*

//TODO: Modificar los stats de los enemigos para que sean acordes y no maten o mueran de un golpe (fuerza y vida)

class Enemigo { 
	var x
	var y
	var ataques
	var itemsQueDropea = [new PocionSalud(), new PocionFuerza(), pocionInmortalidad] //TODO: terminar de poner todos los items
	var property fuerza																//Si agrego mas de un mismo item aumento la chances de drop
	var property statusEffect = ninguno
	var property vida

    method position() = game.at(x,y)

	method esEnemigo() = true
	
	method esAtravesable() = true
	
	method morir() = vida <= 0
	
	method cambiarPosicionEnX(posicion) {
		x = posicion
	}
	
	method pelear(personaje) {
			interfazPelea.iniciar(personaje,self)
		// aca triggereamos la interfaz de pelea
	}

	method atacar(personaje) {
		if(personaje.defendiendo()) {
			self.noPuedeAtacar()
		} else {
			var tipoAtaque = self.getAleatorioDeLista(ataques)
			tipoAtaque.efecto(self,personaje)
			game.addVisual(monsterAttackHit)
			game.onTick(600, "removerAtaqueEnemigo", { => if(game.hasVisual(monsterAttackHit)) game.removeVisual(monsterAttackHit) })
			
		}
	}
	
	method noPuedeAtacar() { // Vendria a ser ataque bloqueado

	}
	
	method sufrirStatusEffect() {
		statusEffect.efectoPorTurno(self) 
	}

	method tieneStatusEffect() {
		return not (self.statusEffect() == ninguno)
	}

	method disminuirVida(valor) {
		vida = 0.max(vida - valor)
	}
	
	method aumentarVida(valor) {
		vida = vida + valor
	}
	
	method disminuirFuerza(valor) {
		fuerza = 0.max(fuerza - valor)
	}
	
	method aumentarFuerza(valor) {
		fuerza = fuerza + valor
	}
	
	method ocuparTurno(personaje) {
		self.sufrirStatusEffect()
		self.atacar(personaje)
	}
	
	method dropear(posicion) {
		var itemDropeado = self.getAleatorioDeLista(itemsQueDropea)
		 game.addVisualIn(itemDropeado, posicion)
	}
	
	method getAleatorioDeLista(lista) {
		return lista.get(0.randomUpTo(lista.size()).roundUp(0) - 1 )  // asi cubro la posicion 0 de enteros
	}
}

class Troll inherits Enemigo {

	var imagen = "troll.png"
	var property pesoGarrote 
	
	method image() = imagen
	
	method modificarImagen() {
		imagen = "trollGrande.png"
	}
	
	method posicionAttackHit() {
		game.addVisualIn(attackHit,game.at(18,6))
	}


}

class Dragon inherits Enemigo {

	var imagen = "dragonVioleta.png"
	
	method image() = imagen

	method modificarImagen() {
		imagen = "dragonVioletaGrande.png"
	}
	
	method posicionAttackHit() {
		game.addVisualIn(attackHit,game.at(17,6))
	}
	
}

// TANTO EL MAGO COMO EL GATO PODRIAN MOVERSE ALEATORIAMENTE EN UN DETERMINADO ESPACIO, SI COLISIONA CON NOSOTROS (HAY QUE EVTARLO)
// NOS ROBA UN ITEM

// FALTA HACER AL MAGO Y AL GATO
class Mago inherits Enemigo {
	
	var imagen = "mago.png"

	method image() = imagen
	
	method modificarImagen() {
		imagen = "magoGrande.png"
	}

	override method atacar(personaje) {
	// robarItemConMasPoder.ataque(personaje)
	}
	
	method posicionAttackHit() {
		game.addVisualIn(attackHit,game.at(16,5))
	}
}

class Gato inherits Enemigo {

	var poderEspada = 70
	var imagen = "gato.png"
	
	method image() = imagen 

	method modificarImagen() {
		imagen = "gatoGrande.png"
	}

	override method atacar(personaje) {
		// robarItemEnMano.ataque(personaje)
		personaje.disminuirVida(2 * poderEspada)
	}
	
	method posicionAttackHit() {
		game.addVisualIn(attackHit,game.at(16,5))
	}
}

class Gigante inherits Enemigo {

	var imagen = "giganteDePiedra.png"

	method image() = imagen

	method modificarImagen() {
		imagen = "giganteDePiedraGrande.png"
	}
	
	method posicionAttackHit() {
		game.addVisualIn(attackHit,game.at(18,6))
	}
}

class PerroDeTresCabezas inherits Enemigo {

	var imagen = "perroDe3CabezasDeFuego.png" 

	method image() = imagen 
	
	method modificarImagen() {
		imagen = "perroDe3CabezasDeFuegoGrande.png"
	}
	
	method posicionAttackHit() {
		game.addVisualIn(attackHit,game.at(17,6))
	}
}

class Guardian inherits Enemigo { //Cuando lo matas se abren las puertas del boss

	var imagen = "guardianBoss.png"
	
	method image() = imagen
	
	method modificarImagen() { 
		imagen = "guardianBossGrande.png"
	}
	
	method posicionAttackHit() {
		game.addVisualIn(attackHit,game.at(16,5))
	}
}

class Boss inherits Enemigo {

	var imagen = "boss.png"
	
	method image() = imagen
	
	method modificarImagen() {
		imagen = "bossGrande.png"
	}
	
	method posicionAttackHit() {
		game.addVisualIn(attackHit,game.at(19,8))
	}
}
