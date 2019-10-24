import wollok.game.*
import items.*
import personajes.*
import ataques.*
import extras.*

class Enemigo { 
	var x
	var y
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

	method atacar(personaje)

}

class Troll inherits Enemigo {

	var imagen = "troll.png" 
	
	method image() = imagen 
	
	method modificarImagen() {
		imagen = "trollGrande.png"
	}

	override method atacar(personaje) {
		personaje.disminuirVida(10 * 3)
	}

}

class Dragon inherits Enemigo {

	var imagen = "dragonVioleta.png"

	
	method image() = imagen

	method modificarImagen() {
		imagen = "dragonVioletaGrande.png"
	}

	override method atacar(personaje) {
		personaje.disminuirVida(300)
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

	var peso = 1000
	var imagen = "giganteDePiedra.png"

	method image() = imagen

	method modificarImagen() {
		imagen = "giganteDePiedraGrande.png"
	}

	override method atacar(personaje) {
		personaje.disminuirVida(peso / 8)
	}
}

class PerroDeTresCabezas inherits Enemigo {

	var imagen = "perroDe3CabezasDeFuego.png" 

	method image() = imagen 
	
	method modificarImagen() {
		imagen = "perroDe3CabezasDeFuegoGrande.png"
	}

	override method atacar(personaje) {
		personaje.disminuirVida(4 * 5)
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








