import wollok.game.*
import personajes.*
import enemigos.*
import items.*
import extras.*

/*
 * object nivel {
 * 
 * 	method iniciar() {
 * 		
 * 	}
 * 	
 * 	method ganar() {
 * 		game.clear()
 * 	}
 * }

 * object config {
 * 	var unItem = new Item(poder = 500)
 *     var unPersonaje = new Personaje(ataque = 100, vida = 100, dignidad = 100, velocidad = 150, item = unItem)
 * 	var unEnemigo = new Enemigo(ataque = 200, vida = 100, velocidad = 90, item = unItem)
 * 	
 * 	method configurarTeclas() {	
 * 		keyboard.left().onPressDo({ unPersonaje.irA(unPersonaje.position().left(1)) })
 * 		keyboard.right().onPressDo({ unPersonaje.irA(unPersonaje.position().right(1)) })
 * 		keyboard.up().onPressDo({ unPersonaje.irA(unPersonaje.position().up(1)) })
 * 		keyboard.down().onPressDo({ unPersonaje.irA(unPersonaje.position().down(1)) })
 * 	}
 * 	
 * 	method configurarColisiones() {
 * 		//game.whenCollideDo(unPersonaje, { enemigo => unPersonaje.atacar() })
 * 		//game.whenCollideDo(unEnemigo, { personaje => unEnemigo.atacar() })
 * 	}

 * 	method configurarAcciones() {
 * 		game.onTick(2 * 1000, "GAMEOVER", { if(unPersonaje.dignidad() == 0) game.stop() })
 * 	}
 * }
 */
object nivel {

	method iniciar() {
		self.agregarExtras()
		self.disenioNivel()
		self.agregarPersonajes()
		config.configurarTeclas()
	// config.configurarColisiones()
	}

	method disenioNivel() {
		self.generarMuroHorizontal()
		self.generarMuroVertical()
	}

	method agregarPersonajes() {
		game.addVisual(scorpion)
			// game.addVisual(enemigo1)
		game.showAttributes(scorpion)
	// game.showAttributes(enemigo1)
	}

	method agregarExtras() {
		game.addVisual(magmaSword)
	}

	method generarMuroVertical() {
		const posicionesParaGenerarMuros = [ game.at(0,5), game.at(5,0) ] // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
	}

	method generarMuroHorizontal() {
		const posicionesParaGenerarMuros = [ game.at(3,4), game.at(0,0) ] // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroHorizontal(), posicion)}
	}

/* 	method configurarAcciones() {
 * 		game.onTick(2 * 1000, "GAMEOVER", { if(unPersonaje.dignidad() == 0) game.stop() })
 * 	}
 */
}

object config {

	method configurarTeclas() {
		// Despues scorpion es reemplazado por 'personaje' (cuando metamos que se pueda elegir pj)	
		keyboard.left().onPressDo({ scorpion.moverse(scorpion.position().left(1), izquierda)})
		keyboard.right().onPressDo({ scorpion.moverse(scorpion.position().right(1), derecha)})
		keyboard.up().onPressDo({ scorpion.moverse(scorpion.position().up(1), arriba)})
		keyboard.down().onPressDo({ scorpion.moverse(scorpion.position().down(1), abajo)})
		keyboard.q().onPressDo({ scorpion.ponerItemSiguienteEnMano()})
	}

/*
 * method configurarColisiones() {
 * 	game.whenCollideDo(scorpion, { enemigo1 => enemigo1.pelear() })
 * 	game.whenCollideDo(enemigo1, { scorpion => scorpion.pelear() })
 } */
}

