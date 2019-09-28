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
		keyboard.space().onPressDo({ unPersonaje.irA(unPersonaje.position().up(2)) })
	}
	
	method configurarColisiones() {
		//game.whenCollideDo(unPersonaje, { enemigo => unPersonaje.atacar() })
		//game.whenCollideDo(unEnemigo, { personaje => unEnemigo.atacar() })
	}

	method configurarAcciones() {
		game.onTick(2 * 1000, "GAMEOVER", { if (unPersonaje.dignidad() == 0) game.stop() })
	}
}
*/