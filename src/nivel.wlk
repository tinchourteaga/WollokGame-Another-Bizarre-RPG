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

	var visualesEnemigos = [ bossVampiro, guardian, troll1, troll2, giganteDePiedra1, giganteDePiedra2, giganteDePiedra3, dragon1, dragon2, perroDeTresCabezas1, perroDeTresCabezas2, mago, gato ]

	method iniciar(personaje) {
		game.clear()
		self.disenioNivel()
		self.agregarPersonajes(personaje)
		config.configurarAcciones(personaje)
		config.configurarTeclas(personaje)
		config.configurarColisiones(personaje)
	}

	method disenioNivel() {
		self.generarMuros()
		self.generarSlotInventario()
		self.agregarElementosDeDisenioExtras()
		self.agregarVisualesExtras()
		self.posicionCalizDeFuego()
	}

	method agregarPersonajes(personaje) {
		// Enemigos
		visualesEnemigos.forEach({ enemigo => game.addVisual(enemigo)})
		// Personaje seleccionado
		game.addVisual(personaje)
		game.showAttributes(personaje)
	}

    method agregarElementosDeDisenioExtras() {
    	self.generarPuertasYBotones()
    	
		game.addVisualIn(puertaIzquierdaBoss, game.at(20, 9))
		game.addVisualIn(puertaDerechaBoss, game.at(21, 9))
		
		game.addVisualIn(trampaPinchos1, game.at(3, 8))
		game.addVisualIn(trampaPinchos2, game.at(3, 9))
		game.addVisualIn(trampaPinchos3, game.at(3, 10))
		game.addVisualIn(trampaPinchos4, game.at(3, 11))
    }

	method agregarVisualesExtras() {
		/*
		 * CUANDO USO ESTO EN VEZ DE LO DE ABAJO BORRA TODO MENOS LOS MUROS, LAS PUERTAS Y LOS BOTONES *
		pociones.forEach({pocion => game.addVisual(pocion)})
		 
		fireBalls.forEach({fireBall => game.addVisual(fireBall)})
		arrows.forEach({arrow => game.addVisual(arrow)})
		*/
        // Pociones
        game.addVisualIn(new PocionSalud(), game.at(8, 5))
        game.addVisualIn(new PocionMana(), game.at(8, 3))
        game.addVisualIn(new PocionVeneno(), game.at(9, 4))
        game.addVisualIn(new EspadaDiamante(), game.at(9, 5))
	
        // Visuales extras
        game.addVisual(fireBall1)
        game.addVisual(fireBall2)
        game.addVisual(fireBall3)
        game.addVisual(arrow1)
        game.addVisual(arrow2)
        game.addVisual(arrow3)
	}

	method generarPuertasYBotones() {
	
		puertas.forEach({puerta => game.addVisual(puerta)})
		botones.forEach({boton => game.addVisual(boton)})
	    /*
		game.addVisual(puerta1)
		game.addVisual(puerta2)
		game.addVisual(puerta3)
		game.addVisual(puerta4)
		game.addVisual(botonTrampa)
		game.addVisual(boton1)
		game.addVisual(boton2)
		game.addVisual(boton3)
	    */
	}

	method generarMuros() {
		const posicionesParaGenerarMuros = (1 .. 12).map({ n => game.at(0, n) })
		posicionesParaGenerarMuros.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const posicionesParaGenerarMuros2 = (1 .. 12).map({ n => game.at(24, n) })
		posicionesParaGenerarMuros2.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const posicionesAMano = [ game.at(11,2), game.at(13,2), game.at(2,5), game.at(3,5), game.at(4,5), game.at(5,5), game.at(6,5), game.at(6,4), game.at(6,3), game.at(6,2) ]
		posicionesAMano.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const segundaEtapa = [ game.at(15,8), game.at(15,10), game.at(15,11) ]
		segundaEtapa.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
		const terceraEtapa = (3 .. 12).map({ n => game.at(17, n) })
		terceraEtapa.forEach{ posicion => game.addVisualIn(new MuroVertical(), posicion)}
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

	var enemigos = [ dragon1, dragon2, perroDeTresCabezas1, perroDeTresCabezas2, mago, gato ] // enemigos que se mueven

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

	method configurarTeclasCombate(personaje, enemigo) {
		keyboard.num1().onPressDo({ personaje.atacar(enemigo)}) // atacar
		keyboard.num2().onPressDo({ personaje.defenderse(enemigo)}) // defender
		// keyboard.num3().onPressDo({  }) //especial (ataque del arma)
		// keyboard.num4().onPressDo({  }) //cambiar de arma -> si no es mucho bardo lo hacemos			
	}

	method configurarColisiones(personaje) {
		fireBalls.forEach({ fireBall => game.whenCollideDo(fireBall, { extra => fireBall.efecto(extra)})})
		arrows.forEach({ arrow => game.whenCollideDo(arrow, { extra => arrow.efecto(extra)})})
	}

	method configurarAcciones(personaje) {
		enemigos.forEach({ enemigo => game.onTick(1000, "Enemigo Moviendose", { enemigo.cambiarPosicionEnX(18.randomUpTo(24))})})
		fireBalls.forEach({ fireBall => game.onTick(fireBall.velocidad(), "FireBall Moviendose", { fireBall.moverFireBall()})})
		arrows.forEach({ arrow => game.onTick(arrow.velocidad(), "Arrow Moviendose", { arrow.moverArrow()})})
		
		game.onTick(1000, "GAMEOVER", { if (personaje.morir()) gameOver.mostrarPantallaGameOver()})
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
		elementosActuales.forEach({ visual => game.addVisual(visual)})
	}

}

object interfazPelea {

	method iniciar(personaje, enemigo) {
		guardarNivel.guardarEstadoActual()
		game.clear()
		self.dibujarInterfaz(personaje, enemigo)
		config.configurarTeclasCombate(personaje, enemigo)
		game.onTick(1000, "GAMEOVER", { if (personaje.morir()) gameOver.mostrarPantallaGameOver()
		})
	}

	method finalizar(personaje, enemigo) {
		game.clear()
		guardarNivel.dibujarNuevoEstado(enemigo)
		config.configurarTeclas(personaje)
		config.configurarColisiones(personaje)
	}

	method dibujarInterfaz(personaje, enemigo) {
		game.addVisualIn(fondo, game.origin())
		enemigo.modificarImagen()
		game.addVisualIn(personaje, game.at(7, 4))
		game.addVisualIn(enemigo, game.at(15, 4))
		game.addVisual(textAtacar)
		game.addVisual(textDefender)
		game.addVisual(textEspecial)
		game.addVisual(textCambiarArma)
		game.showAttributes(personaje)
		game.showAttributes(enemigo)
	}

}

object gameOver {

	method mostrarPantallaGameOver() {
		game.clear()
		game.addVisualIn(fondoGameOver, game.origin())
	}

}

