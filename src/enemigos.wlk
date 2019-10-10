import wollok.game.*
import items.*
import personajes.*

class Enemigo  { 
	var vida
	//var ataque      Cada clase de bicho tiene un ataque distinto (son objetos)
	var position
	var itemQueDropea = #{}
	var property image
	
	// el igual solo se usa para consulta
	method modificarVida(nuevoValor) {
		vida = nuevoValor
	}
	
	method morir() {
		if(vida <= 0){
			game.removeVisual(self)
			game.addVisual(itemQueDropea)
			
		}
	}
}

class Troll inherits Enemigo {
	
	method atacar(enemigo) {
		enemigo.disminuirVida(50)	
	}
}