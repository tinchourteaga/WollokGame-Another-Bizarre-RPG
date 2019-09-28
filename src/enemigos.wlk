import wollok.game.*
import items.*

class Enemigo {
	var vida = 0
	var ataque = 0
	var velocidad = 0
	const item
	const property ataques = #{}
	
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
			game.addVisual(item)
		}
	}
	
	method atacar(estadistica,enemigo) {
		// no se definio todavia como van a ser los ataques
	}
}