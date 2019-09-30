import wollok.game.*
import items.*
import nivel.*
import enemigos.*

class Personaje {
	var ataque = 0
	var vida = 0
	var velocidad = 0
	var dignidad = 0
	var item /* --> Estaba pensando que quizas sería bueno que tenga un size de 3 items ponele y 
				    que pueda ir cambiandolos. Si quiere agarrar otro item y tiene 3, debe soltar 1.
					Los stats mejorados son los del item activo (el que tiene equipado en el momento) */
	var property ataques = #{} // duda
	var property position = game.origin()
	
	method modificarVida(nuevoValor) = (vida = nuevoValor)
	
	method modificarPoderDeAtaque(nuevoValor) = (ataque = nuevoValor)
	
	method modificarVelocidad(nuevoValor) = (velocidad = nuevoValor)
	
	method modificarDignidad(nuevoValor) = (dignidad = nuevoValor)
	
	method mejorarItemQueLleva(itemNuevo) {
		if(dignidad > itemNuevo.poder()){
			item = itemNuevo
		} else {
			game.say(self,"¡No puedo cambiar a este item!")
		}
	}

	method atacar(estadistica,enemigo) {
		  // no se definio todavia como van a ser los ataques
	}

	method morir() {
		if(vida <= 0){
			game.onTick(3000, "Perdiste!" , game.say(self,"Game Over"))
		}
	}
	
	method image()
	
	method moverse(nuevaPosicion) {
		position = nuevaPosicion
	}
}

class Pasiva {
	const ataques = #{} // max 2 ataques?
	var item
	
	method atacarA(enemigo,estadistica) {
		enemigo.modificarEstadistica()
	} 
}

object scorpion { // Mas adelante cuando veamos herencia va a tener que heredar de la clase
	
	var property position = game.at(5,-2) // Solo en este caso para que empiece en cierta parte del mapa
	
	method image() = "scorpion2.png"
	
	method moverse(nuevaPosicion) { // De esta forma no se va mas alla de los bordes de la ventana
		if(nuevaPosicion.x().between(-1,10) && nuevaPosicion.y().between(-2,9)) {
			
			position = nuevaPosicion	
		}
		
	}
	
}