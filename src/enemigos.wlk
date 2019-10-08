import wollok.game.*
import items.*
import personajes.*

object enemigo1 { // cambiar nombre tambien
	var vida = 300
	var ataque = 50
	var velocidad = 30
	var property position = game.at(8,8)
	
	method itemDePaso() = "" // item que deja el enemigo al morir y que nos permite avanzar en el juego
	
	method image() = ""
	
	method modificarVida(nuevoValor) = (vida = nuevoValor)
	
	method modificarPoderDeAtaque(nuevoValor) = (ataque = nuevoValor)
	
	method modificarVelocidad(nuevoValor) = (velocidad = nuevoValor)
	
	method debilidadAnte(unAtaque) {
		unAtaque.atacar(self) // el objeto ataque tiene un mensaje que indica el danio que provoca
	} // los ataques pueden ser objetos y se le asignan a los item, personajes y/o enemigos

	
	method morir() {
		if(vida <= 0){
			game.removeVisual(self)
			//game.addVisual(itemDePaso)
			
		}
	}
	
	//method pelear(enemigo) {
	//	item.ataques().danioQueProvoca(enemigo)
	//}
}