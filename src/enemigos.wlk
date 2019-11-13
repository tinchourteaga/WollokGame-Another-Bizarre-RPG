import wollok.game.*
import items.*
import personajes.*
import ataques.*
import extras.*
import nivel.*

class Enemigo { 
	var x
	var y
	var ataques
	var itemsQueDropea = [new PocionSalud(), new PocionVeneno()] //TODO: terminar de poner todos los items
	var property fuerza
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


}

class Dragon inherits Enemigo {

	var imagen = "dragonVioleta.png"
	
	method image() = imagen

	method modificarImagen() {
		imagen = "dragonVioletaGrande.png"
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
}

class Gigante inherits Enemigo {

	var imagen = "giganteDePiedra.png"

	method image() = imagen

	method modificarImagen() {
		imagen = "giganteDePiedraGrande.png"
	}
}

class PerroDeTresCabezas inherits Enemigo {

	var imagen = "perroDe3CabezasDeFuego.png" 

	method image() = imagen 
	
	method modificarImagen() {
		imagen = "perroDe3CabezasDeFuegoGrande.png"
	}
}

class Guardian inherits Enemigo { //Cuando lo matas se abren las puertas del boss

	var imagen = "guardianBoss.png"
	
	method image() = imagen
	
	method modificarImagen() { 
		imagen = "guardianBossGrande.png"
	}
}

class Boss inherits Enemigo {

	var imagen = "boss.png"
	
	method image() = imagen
	
	method modificarImagen() {
		imagen = "bossGrande.png"
	}
}
