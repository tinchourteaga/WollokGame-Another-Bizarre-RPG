import wollok.game.*
import items.*
import personajes.*
import ataques.*
import extras.*

class Enemigo { 
	var x
	var y
	var property fuerza
	var ataques
	var statusEffect = ninguno
	var vida

    method position() = game.at(x,y)

	method esEnemigo() = true
	
	method esAtravesable() = true
	
	method morir() {
		if (vida <= 0) {
			game.removeVisual(self)
		}
	}
	
	method cambiarPosicionEnX(posicion) {
		x = posicion
	}

	method atacar(personaje) {
		if(personaje.defendiendo()) {
			self.noPuedeAtacar()
		} else {
			var tipoAtaque = ataques.get(0.randomUpTo(2).roundUp(0) - 1 ) // asi cubro la posicion 0 de enteros
			tipoAtaque.efecto(self,personaje)
			
		}
	}
	
	method noPuedeAtacar() {
		self.sufrirStatusEffect()
	}
	
	method sufrirStatusEffect() {
		statusEffect.efectoPorTurno(self) 
	}

	method disminuirVida(valor) {
		vida = vida - valor
	}
	
	method aumentarVida(valor) {
		vida = vida + valor
	}
	
	method ocuparTurno(personaje) {
		self.sufrirStatusEffect()
		self.atacar(personaje)
	}
}

class Troll inherits Enemigo {

	var imagen = "troll.png"
	var ataques = [ataqueBasico, garrotazo]
	var property pesoGarrote
	var fuerza = 100 
	
	method image() = imagen
	
	method modificarImagen() {
		imagen = "trollGrande.png"
	}


}

class Dragon inherits Enemigo {

	var imagen = "dragonVioleta.png"
	var ataques = [incinerar, ataqueBasico]
	var fuerza = 200
	
	method image() = imagen

	method modificarImagen() {
		imagen = "dragonVioletaGrande.png"
	}
}

// TANTO EL MAGO COMO EL GATO PODRIAN MOVERSE ALEATORIAMENTE EN UN DETERMINADO ESPACIO, SI COLISIONA CON NOSOTROS (HAY QUE EVTARLO)
// NOS ROBA UN ITEM
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
	var ataques = [ataqueBasico, aplastar]
	var fuerza = 250

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
	
	method modificarImagen() {  // DE ESTA FORMA FUNCIONA EL CAMBIO DE IMAGEN, SI LO HAGO COMO EN PERSONAJE NO
		imagen = "guardianBossGrande.png"
	}
	
	override method morir() {
		puertaDerechaBoss.abreteSesamo()
		puertaIzquierdaBoss.abreteSesamo()
		super()
	}
	
	override method atacar(personaje) {
		absorberVida.efecto(self,personaje)
	}
}








