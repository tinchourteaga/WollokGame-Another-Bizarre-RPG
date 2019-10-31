import wollok.game.*
import items.*
import personajes.*
import ataques.*
import extras.*
import nivel.*

// TODO: aunque marque errores funciona igual, pasa que es una putita

///////////////////////////////////////////////

var bossVampiro = new Boss(x = 14, y = 4, vida = 3000) // x=20 y=10
var guardian = new Guardian(x = 23, y = 10, vida = 1000)
var troll1 = new Troll(x = 16, y = 4, vida = 300, pesoGarrote = 200)
var troll2 = new Troll(x = 16, y = 3, vida = 450, pesoGarrote = 100)
var giganteDePiedra1 = new Gigante(x = 3, y = 4, vida = 550)
var giganteDePiedra2 = new Gigante(x = 3, y = 2, vida = 500)
var giganteDePiedra3 = new Gigante(x = 1, y = 3, vida = 500)
var dragon1 = new Dragon(x = 21, y = 6, vida = 800)
var dragon2 = new Dragon(x = 20, y = 5, vida = 800)
var perroDeTresCabezas1 = new PerroDeTresCabezas(x = 18, y = 4, vida = 600)
var perroDeTresCabezas2 = new PerroDeTresCabezas(x = 23, y = 3, vida = 600)
var mago = new Mago(x = 18, y = 7, vida = 500)
var gato = new Gato(x = 19, y = 8, vida = 500)

///////////////////////////////////////////////

class Enemigo { 
	var x
	var y
	var ataques
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

	method atacar(personaje) {
		if(personaje.defendiendo()) {
			self.noPuedeAtacar()
		} else {
			var tipoAtaque = ataques.get(0.randomUpTo(ataques.size()).roundUp(0) - 1 ) // asi cubro la posicion 0 de enteros
			tipoAtaque.efecto(self,personaje)
			
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
	var fuerza = 250
	
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
	var ataques = [ataqueBasico, aplastar]
	var fuerza = 250

	method image() = imagen

	method modificarImagen() {
		imagen = "giganteDePiedraGrande.png"
	}
}

class PerroDeTresCabezas inherits Enemigo {

	var imagen = "perroDe3CabezasDeFuego.png"
	var ataques = [ataqueBasico, mordidaDeFuego]
	var fuerza = 150 

	method image() = imagen 
	
	method modificarImagen() {
		imagen = "perroDe3CabezasDeFuegoGrande.png"
	}
}

class Guardian inherits Enemigo { //Cuando lo matas se abren las puertas del boss

	var imagen = "guardianBoss.png"
	var ataques = [ataqueBasico, absorberVida, incinerar, envenenar]
	var fuerza = 175
	
	method image() = imagen
	
	method modificarImagen() { 
		imagen = "guardianBossGrande.png"
	}
}

class Boss inherits Enemigo {

	var imagen = "boss.png"
	var ataques = [ataqueBasico, envenenar, electrocutar, debilitar, absorberVida, buffearse, festinDeSangre]
	var fuerza = 300
	
	method image() = imagen
	
	method modificarImagen() {
		imagen = "bossGrande.png"
	}
}








