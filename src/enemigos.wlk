import wollok.game.*
import items.*
import personajes.*
import ataques.*
import extras.*

// TODO: aunque marque errores funciona igual, pasa que es una putita

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
			// fin interfaz pelea. Restauro nivel
		}
	}
	
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
		self.sufrirStatusEffect()
	}
	
	method sufrirStatusEffect() {
		statusEffect.efectoPorTurno(self) 
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
	
	method modificarImagen() {  // DE ESTA FORMA FUNCIONA EL CAMBIO DE IMAGEN, SI LO HAGO COMO EN PERSONAJE NO
		imagen = "guardianBossGrande.png"
	}
	
	override method morir() {
		[puertaDerechaBoss, puertaIzquierdaBoss].forEach({ puerta => puerta.abreteSesamo() })
		super()
	}
}

class Boss inherits Enemigo {

	var imagen = "boss.png"
	//var vida = 3000
	
	//override method position() = game.at(14,4) // 20,10
	
	method image() = imagen
	
	method modificarImagen() {
		imagen = "bossGrande.png"
	}
}

// Declaracion de Enemigos

var bossVampiro = new Boss(x = 14, y = 4, vida = 3000, ataques = [ataqueBasico, envenenar, electrocutar, debilitar, absorberVida, buffearse, festinDeSangre], fuerza = 300)
var guardian = new Guardian(x = 23, y = 10, vida = 1000, ataques = [ataqueBasico, absorberVida, incinerar, envenenar], fuerza = 175)
var troll1 = new Troll(x = 16, y = 4, vida = 300, pesoGarrote = 200, ataques = [ataqueBasico, garrotazo], fuerza = 100)
var troll2 = new Troll(x = 16, y = 3, vida = 450, pesoGarrote = 100, ataques = [ataqueBasico, garrotazo], fuerza = 100)
var giganteDePiedra1 = new Gigante(x = 3, y = 4, vida = 550, ataques = [ataqueBasico, aplastar], fuerza = 250)
var giganteDePiedra2 = new Gigante(x = 3, y = 2, vida = 500, ataques = [ataqueBasico, aplastar], fuerza = 250)
var giganteDePiedra3 = new Gigante(x = 1, y = 3, vida = 500, ataques = [ataqueBasico, aplastar], fuerza = 250)
var dragon1 = new Dragon(x = 21, y = 6, vida = 800, ataques = [incinerar, ataqueBasico], fuerza = 250)
var dragon2 = new Dragon(x = 20, y = 5, vida = 800, ataques = [incinerar, ataqueBasico], fuerza = 250)
var perroDeTresCabezas1 = new PerroDeTresCabezas(x = 18, y = 4, vida = 600, ataques = [ataqueBasico, mordidaDeFuego], fuerza = 150)
var perroDeTresCabezas2 = new PerroDeTresCabezas(x = 23, y = 3, vida = 600, ataques = [ataqueBasico, mordidaDeFuego], fuerza = 150)
var mago = new Mago(x = 18, y = 7, vida = 500, ataques = [], fuerza = 50)
var gato = new Gato(x = 19, y = 8, vida = 500, ataques = [], fuerza = 65)