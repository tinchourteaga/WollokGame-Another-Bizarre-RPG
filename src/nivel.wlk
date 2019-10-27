import wollok.game.*
import personajes.*
import enemigos.*
import items.*
import extras.*

object seleccionDePersonaje {

	method iniciar() {
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

	
	var guardian = new Guardian(x = 23, y = 10, vida = 1000)
	var troll1 = new Troll(x = 16, y = 4, vida = 300, pesoGarrote = 200)
    var troll2 = new Troll(x = 16, y = 3, vida = 450, pesoGarrote = 100)
    var giganteDePiedra1 = new Gigante(x = 3, y = 4, vida = 550)
    var giganteDePiedra2 = new Gigante(x = 3, y = 2, vida = 500)
    var giganteDePiedra3 = new Gigante(x = 1, y = 3, vida = 500)
    var dragon1 = new Dragon(x = 21, y = 6, vida = 800)
    var dragon2 = new Dragon(x = 20, y = 5, vida = 800)
    var perroDeTresCabezas1 = new PerroDeTresCabezas(x = 18, y = 4, vida = 600)
    var perroDeTresCabezas2 = new PerroDeTresCabezas(x = 23, y = 3, vida = 600)
    var mago = new Mago(x = 18, y = 7, vida = 500)
    var gato = new Gato(x = 19, y = 8, vida = 500)
 
	method iniciar(personaje) {
		game.clear()
		self.disenioNivel()
		self.agregarPersonajes(personaje)
		self.efectos()
		config.configurarTeclas(personaje)
		config.configurarColisiones(personaje)
	}

	method disenioNivel() {
		self.generarMuroVertical()
		self.generarMuroHorizontal()
		self.generarSlotInventario()
		self.agregarVisualesExtras()
		self.posicionCalizDeFuego()
	}

	method agregarPersonajes(personaje) {
		
		//ENEMIGOS

		game.addVisual(guardian) // descomentar cuando se haya modificado el metodo image() del resto, si no, no corre
								// replicar la forma de hacerlo como la del guardian
		game.addVisual(troll1)
		game.addVisual(troll2)
		game.addVisual(giganteDePiedra1)
		game.addVisual(giganteDePiedra2)
		game.addVisual(giganteDePiedra3)
		game.addVisual(dragon1) //game.at(21,6)
		game.onTick(700, "moverse", {=> dragon1.cambiarPosicionEnX(18.randomUpTo(24))})		
		game.addVisual(dragon2) //game.at(20,5)
		game.onTick(700, "moverse", {=> dragon2.cambiarPosicionEnX(18.randomUpTo(24))})
		game.addVisual(perroDeTresCabezas1) //game.at(18,4) 
		game.onTick(700, "moverse", {=> perroDeTresCabezas1.cambiarPosicionEnX(18.randomUpTo(24))})
		game.addVisual(perroDeTresCabezas2) //game.at(23,3)
		game.onTick(700, "moverse", {=> perroDeTresCabezas2.cambiarPosicionEnX(18.randomUpTo(24))})

		game.addVisual(mago) //game.at(18,7)
		game.addVisual(gato) //game.at(19,8)

		game.addVisual(personaje)
		game.showAttributes(personaje)
	}

	method efectos() {
		game.onTick(350, "movete", { arrow.moverArrow()})
		game.onTick(250, "movete", { fireBall.moverFireball()})
		game.onTick(150, "movete", { spike.moverSpike()})
		game.onTick(700, "moverse", {=> dragon1.cambiarPosicionEnX(18.randomUpTo(24))})
		game.onTick(700, "moverse", {=> dragon2.cambiarPosicionEnX(18.randomUpTo(24))})
		game.onTick(700, "moverse", {=> perroDeTresCabezas1.cambiarPosicionEnX(18.randomUpTo(24))})
		game.onTick(700, "moverse", {=> perroDeTresCabezas2.cambiarPosicionEnX(18.randomUpTo(24))})
		game.onTick(700, "moverse", {=> mago.cambiarPosicionEnX(18.randomUpTo(24))})
		game.onTick(700, "moverse", {=> gato.cambiarPosicionEnX(18.randomUpTo(24))})
	}

	method agregarVisualesExtras() {
		self.generarPuertasYBotones()
		game.addVisualIn(puertaIzquierdaBoss, game.at(20, 9))
		game.addVisualIn(puertaDerechaBoss, game.at(21, 9))
		game.addVisualIn(trampaPinchos1, game.at(3, 8))
		game.addVisualIn(trampaPinchos2, game.at(3, 9))
		game.addVisualIn(trampaPinchos3, game.at(3, 10))
		game.addVisualIn(trampaPinchos4, game.at(3, 11))
		game.addVisualIn(new PocionSalud(), game.at(8, 5))
		game.addVisualIn(new PocionMana(), game.at(8, 3))
		game.addVisualIn(new PocionVeneno(), game.at(9, 4))
		game.addVisualIn(new EspadaDiamante(), game.at(9, 5))
		game.addVisual(fireBall)
		game.addVisual(arrow)
		game.addVisual(spike)
	}

	method generarPuertasYBotones() {
		const puerta1 = new PuertaHorizontal()
		const puerta4 = new PuertaHorizontal()
		const puerta3 = new PuertaVertical()
		const puerta2 = new PuertaVertical()
		game.addVisualIn(puerta1, game.at(1, 5))
		game.addVisualIn(puerta2, game.at(17, 2))
		game.addVisualIn(puerta3, game.at(15, 9))
		game.addVisualIn(puerta4, game.at(16, 7))

		game.addVisualIn(new BotonTrampa(puertaQueAcciona = puerta1), game.at(7, 2))
		game.addVisualIn(new Boton(puertaQueAcciona = puerta2), game.at(1, 8))
		game.addVisualIn(new Boton(puertaQueAcciona = puerta3), game.at(16, 11))
		game.addVisualIn(new Boton(puertaQueAcciona = puerta4), game.at(5, 3))
	}

	method generarMuroVertical() {
		const posicionesParaGenerarMuros = (1 .. 12).map({ n => game.at(0, n) }) // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const posicionesParaGenerarMuros2 = (1 .. 12).map({ n => game.at(24, n) }) // A manopla o hay alguna forma mas eficiente que no veo??
		posicionesParaGenerarMuros2.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const posicionesAMano = [ game.at(11,2), game.at(13,2), game.at(2,5), game.at(3,5), game.at(4,5), game.at(5,5), game.at(6,5), game.at(6,4), game.at(6,3), game.at(6,2) ]
		posicionesAMano.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const segundaEtapa = [ game.at(15,8), game.at(15,10), game.at(15,11) ]
		segundaEtapa.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const terceraEtapa = (3 .. 12).map({ n => game.at(17, n) })
		terceraEtapa.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
	}

	method generarMuroHorizontal() {
		const posicionesParaGenerarMuros = (1 .. 25).map({ n => game.at(n, 1) })
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const posicionesParaGenerarMuros2 = (1 .. 25).map({ n => game.at(n, 12) })
		posicionesParaGenerarMuros2.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const segundaEtapa = (1 .. 15).map({ n => game.at(n, 7) })
		segundaEtapa.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
	}

	method posicionCalizDeFuego() {
		const posicionCaliz = [ game.at(18,11), game.at(23,11), game.at(19,10), game.at(22,10), game.at(19,11), game.at(22,11), game.at(19,9), game.at(22,9) ]
		posicionCaliz.forEach{ posicion => game.addVisualIn(new Caliz(), posicion)}
	}

	method generarSlotInventario() {
		const posicionesInventario = [ game.at(0,0), game.at(1,0), game.at(2,0), game.at(3,0), game.at(4,0) ]
		posicionesInventario.forEach{ posicion => game.addVisualIn(new BloqueInventario(), posicion)}
	}

}

object config {

	method seleccionarPersonajes() {
		keyboard.num0().onPressDo({ nivel.iniciar(scorpion)})
		keyboard.num1().onPressDo({ nivel.iniciar(gandalf)})
	}

	method configurarTeclas(personaje) {
		keyboard.left().onPressDo({ personaje.moverse(personaje.position().left(1), izquierda, personaje)})
		keyboard.right().onPressDo({ personaje.moverse(personaje.position().right(1), derecha, personaje)})
		keyboard.up().onPressDo({ personaje.moverse(personaje.position().up(1), arriba, personaje)})
		keyboard.down().onPressDo({ personaje.moverse(personaje.position().down(1), abajo, personaje)})
		keyboard.q().onPressDo({ personaje.ponerItemSiguienteEnMano()})
		keyboard.e().onPressDo({ game.colliders(personaje).head().accionarBoton(personaje)})
		keyboard.a().onPressDo({ personaje.agarrarItem()})
		keyboard.d().onPressDo({ personaje.dejarItemEnMano()})
	
	}
	
	method configurarTeclasCombate(personaje,enemigo) {
		keyboard.num1().onPressDo({ personaje.atacar(enemigo) }) //atacar
		keyboard.num2().onPressDo({ personaje.defenderse(enemigo) }) //defender
		//keyboard.num3().onPressDo({  }) //especial (ataque del arma)
		//keyboard.num4().onPressDo({  }) //cambiar de arma -> si no es mucho bardo lo hacemos			
	}

	method configurarColisiones(personaje) {
		// game.whenCollideDo(enemigo, {personaje => enemigo.pelear(personaje)})
		// game.whenCollideDo(personaje, { extra => personaje.morir(extra)})
		game.whenCollideDo(personaje, { enemigo => personaje.pelear(enemigo)})
		game.whenCollideDo(fireBall, { extra => fireBall.efecto(extra)})
		game.whenCollideDo(arrow, { extra => fireBall.efecto(extra)})
		game.whenCollideDo(spike, { extra => fireBall.efecto(extra)})
		
	}

}

object guardarNivel {
	
	var elementosActuales = []
	
	method guardarEstadoActual() {
		elementosActuales.addAll(game.allVisuals())
	}
	
	method dibujarNuevoEstado(enemigo) {
		game.clear()
		elementosActuales.remove(enemigo)
		self.dibujarVisuals()
	}
	
	method dibujarVisuals() {
		elementosActuales.forEach({ visual => game.addVisual(visual) })
	}
}

object interfazPelea {
	
	method iniciar(personaje,enemigo) {
		guardarNivel.guardarEstadoActual()
		game.clear()
		self.dibujarInterfaz(personaje,enemigo)
		config.configurarTeclasCombate(personaje,enemigo)
		
	}
	
	method finalizar(personaje,enemigo) {
		game.clear()
		guardarNivel.dibujarNuevoEstado(enemigo)
		config.configurarTeclas(personaje)
		config.configurarColisiones(personaje)
	}
	
	method dibujarInterfaz(personaje,enemigo) {
		game.addVisualIn(fondo,game.origin())
		enemigo.modificarImagen()
		game.addVisualIn(personaje,game.at(7,4))
		game.addVisualIn(enemigo,game.at(15,4))
		game.addVisual(textAtacar)
		game.addVisual(textDefender)
		game.addVisual(textEspecial)
		game.addVisual(textCambiarArma)
		game.showAttributes(personaje)
		game.showAttributes(enemigo)
	}
}




