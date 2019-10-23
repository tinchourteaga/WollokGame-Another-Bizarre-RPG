import wollok.game.*
import personajes.*
import enemigos.*
import items.*
import extras.*


object seleccionDePersonaje {

	method iniciar() {
		game.ground("piso.jpg")
		config.seleccionarPersonajes()
		self.dibujarPersonajesEnSeleccion()
		self.dibujarTextos()
	}
	
	method dibujarPersonajesEnSeleccion() {
		game.addVisual(scorpionSeleccion)
		game.addVisual(gandalfSeleccion)
	}
	
	method dibujarTextos() {
		game.addVisual(seleccionPersonajeTextBox)
		game.addVisual(scorpionTextBox)
		game.addVisual(gandalfTextBox)
	}
	
}

object nivel {
	
	var trollDePiedra = new Troll(x = 15, y = 9, vida = 300, velocidad = 5, image = "trollDePiedra.png")
    var trollDemonio = new Troll(x = 16, y = 7, vida = 450, velocidad = 35, image = "trollDemonio.png")
    var giganteDePiedra = new Gigante(x = 3, y = 4, vida = 550, velocidad = 2, image = "giganteDePiedra.png")
    var giganteDeHielo = new Gigante(x = 3, y = 2, vida = 500, velocidad = 2, image = "giganteDeHielo.png")
    var giganteVioleta = new Gigante(x = 2, y = 3, vida = 500, velocidad = 2, image = "giganteDeManaosDeUva.png")
    var dragonVerde = new Dragon(x = 21, y = 6, vida = 800, velocidad = 55, image = "dragonVerde.png")
    var dragonVioleta = new Dragon(x = 20, y = 5, vida = 800, velocidad = 55, image = "dragonVioleta.png")
    var perroDeTresCabezasDeHielo = new PerroDeTresCabezas(x = 18, y = 4, vida = 600, velocidad = 40, image = "perroDe3CabezasDeHielo.png")
    var perroDeTresCabezasDeFuego = new PerroDeTresCabezas(x = 23, y = 3, vida = 600, velocidad = 45, image = "perroDe3CabezasDeFuego.png")
    var mago = new Mago(x = 18, y = 7, vida = 500, velocidad = 25, image = "mago.png")
    var gato = new Gato(x = 19, y = 8, vida = 500, velocidad = 50, image = "gato.png")
 
	method iniciar(personaje) {
		game.clear()
		self.disenioNivel()
		self.agregarPersonajes(personaje)
		config.configurarTeclas(personaje)
		config.configurarColisiones(personaje)
	}

	method disenioNivel() {
		self.generarMuroVertical()
		self.generarMuroHorizontal()
		self.generarSlotInventario()
		self.agregarVisualesExtras()
	}

	method agregarPersonajes(personaje) {
		// enemigos
		game.addVisualIn(trollDePiedra,game.at(15,9))
		game.addVisualIn(trollDemonio,game.at(16,7))
		game.addVisualIn(giganteDePiedra,game.at(3,4))
		game.addVisualIn(giganteDeHielo,game.at(3,2))
		game.addVisualIn(giganteVioleta,game.at(2,3))
		game.addVisual(dragonVerde) //game.at(21,6)
		game.onTick(700, "moverse", {=> dragonVerde.cambiarPosicionEnX(18.randomUpTo(24))})		
		game.addVisual(dragonVioleta) //game.at(20,5)
		game.onTick(700, "moverse", {=> dragonVioleta.cambiarPosicionEnX(18.randomUpTo(24))})
		game.addVisual(perroDeTresCabezasDeHielo) //game.at(18,4) 
		game.onTick(700, "moverse", {=> perroDeTresCabezasDeHielo.cambiarPosicionEnX(18.randomUpTo(24))})
		game.addVisual(perroDeTresCabezasDeFuego) //game.at(23,3)
		game.onTick(700, "moverse", {=> perroDeTresCabezasDeFuego.cambiarPosicionEnX(18.randomUpTo(24))})
		game.addVisual(mago) //game.at(18,7)
		game.onTick(700, "moverse", {=> mago.cambiarPosicionEnX(18.randomUpTo(24))})
		game.addVisual(gato) //game.at(19,8)
		game.onTick(700, "moverse", {=> gato.cambiarPosicionEnX(18.randomUpTo(24))})
		// personaje
		game.addVisual(personaje)
		//game.showAttributes(personaje)
	}

	method agregarVisualesExtras() {
		//self.posicionPinchos()
		game.addVisualIn(new Boton(puertaQueAcciona = puerta1), game.at(12,5))
		game.addVisualIn(puerta1,game.at(10,5)) 
		game.addVisualIn(new PocionSalud(), game.at(8,5))
		game.addVisualIn(new PocionMana(), game.at(8,3))
		game.addVisualIn(new PocionVeneno(), game.at(9,4))		
		game.addVisual(fireBall)
		game.addVisual(arrow)
		game.addVisual(spike)
		game.onTick(350, "movete",{ arrow.moverArrow()})
		game.onTick(250,"movete",{ fireBall.moverFireball()})
		game.onTick(150,"movete",{spike.moverSpike()})
		//game.addVisualIn(new PocionSalud(	), game.at(8, 5))
	}

	method posicionPinchos() {
		const posicionesParaGenerarPinchos = (8 .. 11).map({ n => game.at(14, n) })
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

}

object config {

	method seleccionarPersonajes() {
		keyboard.num0().onPressDo({ nivel.iniciar(scorpion) })
		keyboard.num1().onPressDo({ nivel.iniciar(gandalf) })
	}

	method configurarTeclas(personaje) {	
		keyboard.left().onPressDo({ personaje.moverse(personaje.position().left(1), izquierda, personaje) })
		keyboard.right().onPressDo({ personaje.moverse(personaje.position().right(1), derecha, personaje) })
		keyboard.up().onPressDo({ personaje.moverse(personaje.position().up(1), arriba, personaje) })
		keyboard.down().onPressDo({ personaje.moverse(personaje.position().down(1), abajo, personaje) })
		keyboard.q().onPressDo({ personaje.ponerItemSiguienteEnMano() })
		keyboard.k().onPressDo({ game.colliders(personaje).head().accionarBoton(personaje) })
		keyboard.f().onPressDo({ personaje.agarrarItem() })
		keyboard.g().onPressDo({ personaje.dejarItemEnMano() })
		keyboard.r().onPressDo({ personaje.pelear(game.colliders(personaje).head()) })
	}

	method configurarColisiones(personaje) {
		game.whenCollideDo(personaje, { enemigo => personaje.pelear(enemigo) })
		game.whenCollideDo(fireBall, { => fireBall.daniarPersonaje(personaje) })
		
	}

}
/*
 method configurarAcciones(personaje) {
    	game.onTick(2 * 1000, "GAMEOVER", { if(personaje.vida() == 0) game.stop() })
 }
}
*/