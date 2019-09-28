import wollok.game.*

class Personaje {
	var ataque = 0
	var vida = 0
	var velocidad = 0
	var dignidad = 0
	var item
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
	
	method image() = ""
}

class Pasiva {
	const ataques = #{} // max 2 ataques?
	var item
	
	method atacarA(enemigo,estadistica) {
		enemigo.modificarEstadistica()
	} 
}