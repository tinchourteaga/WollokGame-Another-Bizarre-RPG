import wollok.game.*
import personajes.*
import enemigos.*
import items.*
/*
object nivel {
	var unItem = new Item(poder = 500)                                                                            // ejemplos
	var unPersonaje = new Personaje(ataque = 100, vida = 100, dignidad = 100, velocidad = 150, item = unItem)
	var unEnemigo = new Enemigo(ataque = 200, vida = 100, velocidad = 90, item = unItem)
	
	method iniciar() {
		
	}
	
	method ganar() {
		game.clear()
	}
}

object config {
	var unItem = new Item(poder = 500)
    var unPersonaje = new Personaje(ataque = 100, vida = 100, dignidad = 100, velocidad = 150, item = unItem)
	var unEnemigo = new Enemigo(ataque = 200, vida = 100, velocidad = 90, item = unItem)
	
	method configurarTeclas() {	
		keyboard.left().onPressDo({ unPersonaje.irA(unPersonaje.position().left(1)) })
		keyboard.right().onPressDo({ unPersonaje.irA(unPersonaje.position().right(1)) })
		keyboard.up().onPressDo({ unPersonaje.irA(unPersonaje.position().up(1)) })
		keyboard.down().onPressDo({ unPersonaje.irA(unPersonaje.position().down(1)) })
	}
	
	method configurarColisiones() {
		//game.whenCollideDo(unPersonaje, { enemigo => unPersonaje.atacar() })
		//game.whenCollideDo(unEnemigo, { personaje => unEnemigo.atacar() })
	}

	method configurarAcciones() {
		game.onTick(2 * 1000, "GAMEOVER", { if(unPersonaje.dignidad() == 0) game.stop() })
	}
}
*/

object nivel1 {
	
	method iniciar() {
		
		self.agregarPersonajes()
		config.configurarTeclas()
			
	}
	
	method agregarPersonajes() {
		game.addVisual(scorpion)
	}
}

object config {
	
	method configurarTeclas() {
		
		keyboard.left().onPressDo({ scorpion.moverse(scorpion.position().left(1))})
		keyboard.right().onPressDo({ scorpion.moverse(scorpion.position().right(1))})
		keyboard.up().onPressDo({ scorpion.moverse(scorpion.position().up(1))})
		keyboard.down().onPressDo({ scorpion.moverse(scorpion.position().down(1))})
	}
	
	method configurarColisiones() {
		
		
	}
}











