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
object seleccionDePersonaje {

	method iniciar() {
		game.boardGround("seleccionDePersonaje.jpg")
		config.seleccionarPersonajes()
	}

}

object nivel1 {

	method iniciar(personaje) {
		game.ground("piso.png") // aca va el nombre de la imagen de fondo
		self.agregarPersonajes(personaje)
		self.disenioNivel()
		config.configurarTeclas(personaje)
	}

	method disenioNivel() {
		self.generarMuroVertical()
		self.generarMuroHorizontal()
		self.generarSlotInventario()
		self.agregarVisualesExtras()
	}

	method agregarPersonajes(personaje) {
		game.addVisual(personaje)
//		game.addVisual(enemigo1)
		game.showAttributes(personaje)
		game.addVisualIn(escalera, game.at(12, 2))
	// game.showAttributes(enemigo1)
	}

	method agregarVisualesExtras() {
		self.posicionPinchos()
		game.addVisualIn(button, game.at(3, 3)) // hay que achicarlo
		game.addVisualIn(new PocionSalud(), game.at(8,5))
	}

	method posicionPinchos() {
		const posicionesParaGenerarPinchos = (8 .. 11).map({ n => game.at(14, n) }) // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarPinchos.forEach{ posicion => game.addVisualIn(new Pinchos(), posicion)}
	}

	method generarMuroVertical() {
		const posicionesParaGenerarMuros = (1 .. 12).map({ n => game.at(0, n) }) // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const posicionesParaGenerarMuros2 = (1 .. 12).map({ n => game.at(24, n) }) // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarMuros2.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const posicionesAMano = [ game.at(11,2), game.at(13,2), game.at(2,5), game.at(3,5), game.at(4,5), game.at(5,5), game.at(6,5), game.at(6,4), game.at(6,3), game.at(6,2) ]
		posicionesAMano.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const segundaEtapa = [ game.at(15,8), game.at(15,10), game.at(15,11) ]
		segundaEtapa.forEach{ posicion => game.addVisualIn(new MuroHorizontal(), posicion)}
		const terceraEtapa = (3 .. 12).map({ n => game.at(17, n) })
		terceraEtapa.forEach{ posicion => game.addVisualIn(new MuroHorizontal(), posicion)}
	}

	method generarMuroHorizontal() {
		const posicionesParaGenerarMuros = (1 .. 25).map({ n => game.at(n, 1) })
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroHorizontal(), posicion)}
		const posicionesParaGenerarMuros2 = (1 .. 25).map({ n => game.at(n, 12) })
		posicionesParaGenerarMuros2.forEach{ posicion => game.addVisualIn(new MuroHorizontal(), posicion)}
		const segundaEtapa = (1 .. 15).map({ n => game.at(n, 7) })
		segundaEtapa.forEach{ posicion => game.addVisualIn(new MuroHorizontal(), posicion)}
	}
	
	method generarSlotInventario() {
		const posicionesInventario = [ game.at(0,0), game.at(1,0), game.at(2,0), game.at(3,0), game.at(4,0) ]
		posicionesInventario.forEach{ posicion => game.addVisualIn(new BloqueInventario(), posicion)}
	}

/* 	method configurarAcciones() {
 * 		game.onTick(2 * 1000, "GAMEOVER", { if(unPersonaje.dignidad() == 0) game.stop() })
 * 	}
 */
}

object nivel2 {

	method iniciar(personaje) {
		game.ground("piso.png") // aca va el nombre de la imagen de fondo
		self.agregarPersonajes(personaje)
		self.disenioNivel()
		config.configurarTeclas(personaje)
		config.configurarColisionesNivel1(personaje)
	}

	method disenioNivel() {
		self.generarMuroVertical()
		self.generarMuroHorizontal()
	}

	method agregarPersonajes(personaje) {
		game.addVisual(personaje)
		game.showAttributes(personaje)
	}

	method generarMuroVertical() {
		const posicionesParaGenerarMuros = (1 .. 12).map({ n => game.at(0, n) }) // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const posicionesParaGenerarMuros2 = (1 .. 12).map({ n => game.at(24, n) }) // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarMuros2.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
	}

	method generarMuroHorizontal() {
		const posicionesParaGenerarMuros = (1 .. 25).map({ n => game.at(n, 1) })
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroHorizontal(), posicion)}
		const posicionesParaGenerarMuros2 = (1 .. 25).map({ n => game.at(n, 12) })
		posicionesParaGenerarMuros2.forEach{ posicion => game.addVisualIn(new MuroHorizontal(), posicion)}
	}

}

object config {

	method seleccionarPersonajes() {
		keyboard.num0().onPressDo({ nivel1.iniciar(scorpion)})
		keyboard.num1().onPressDo({ nivel1.iniciar(gandalf)})
	}

	method configurarTeclas(personaje) {
		// Despues scorpion es reemplazado por 'personaje' (cuando metamos que se pueda elegir pj)	
		keyboard.left().onPressDo({ personaje.moverse(personaje.position().left(1), izquierda, personaje)})
		keyboard.right().onPressDo({ personaje.moverse(personaje.position().right(1), derecha, personaje)})
		keyboard.up().onPressDo({ personaje.moverse(personaje.position().up(1), arriba, personaje)})
		keyboard.down().onPressDo({ personaje.moverse(personaje.position().down(1), abajo, personaje)})
		keyboard.q().onPressDo({ personaje.ponerItemSiguienteEnMano()})
		keyboard.k().onPressDo({ game.colliders(personaje).head().accionarBoton(personaje)})
		keyboard.f().onPressDo({ personaje.agarrarItem() })
		keyboard.g().onPressDo({ personaje.dejarItemEnMano() })
	}

	method configurarColisionesNivel1(personaje) {
		game.whenCollideDo(personaje, { escalera => game.clear()})
		game.whenCollideDo(personaje, { escalera => nivel2.iniciar(personaje)})
	}

}

