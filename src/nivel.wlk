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

	method iniciar(personaje) {
		game.clear()
		self.disenioNivel()
		self.agregarPersonajes(personaje)
		config.configurarAcciones(personaje)
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
		
		// Enemigos
		enemigos.forEach({ enemigo => game.addVisual(enemigo)})
		
		// Personaje seleccionado
		game.addVisual(personaje)
		game.showAttributes(personaje)
	}

	method agregarVisualesExtras() {
		
		self.generarPuertasYBotones()
		
		game.addVisualIn(trampaPinchos1, game.at(3, 8))
		game.addVisualIn(trampaPinchos2, game.at(3, 9))
		game.addVisualIn(trampaPinchos3, game.at(3, 10))
		game.addVisualIn(trampaPinchos4, game.at(3, 11))
		
		game.addVisualIn(new PocionSalud(), game.at(8, 5))
		game.addVisualIn(new PocionMana(), game.at(8, 3))
		game.addVisualIn(new PocionVeneno(), game.at(9, 4))
		game.addVisualIn(new EspadaDiamante(), game.at(9, 5))
		game.addVisualIn(new BastonMagico(), game.at(9, 6))
		
        game.addVisual(fireBall1)
        game.addVisual(fireBall2)
        game.addVisual(fireBall3)
        game.addVisual(arrow1)
        game.addVisual(arrow2)
        game.addVisual(arrow3)
	}

	method generarPuertasYBotones() {
		//puertas.forEach({puerta => game.addVisual(puerta)}) DE ESTA FORMA ROMPE
		//botones.forEach({boton => game.addVisual(boton)})
		
        game.addVisual(puerta1)
        game.addVisual(puerta2)
        game.addVisual(puerta3)
        game.addVisual(puerta4)
        game.addVisual(puertaDerechaBoss)
		game.addVisual(puertaIzquierdaBoss)
		game.addVisual(botonTrampa)
        game.addVisual(boton1)
        game.addVisual(boton2)
        game.addVisual(boton3)
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
	
	var enemigosMovimiento = [ dragon1, dragon2, perroDeTresCabezas1, perroDeTresCabezas2, mago, gato ]

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
		keyboard.num3().onPressDo({ personaje.ataqueEspecial(enemigo) }) //especial (ataque del arma)
		keyboard.num4().onPressDo({ personaje.cambiarArma() }) //cambiar de arma	TODO: testear si funciona	
	}

	method configurarColisiones(personaje) {
		game.whenCollideDo(personaje, { enemigo => personaje.pelear(enemigo)})
		fireBalls.forEach({ fireBall => game.whenCollideDo(fireBall, { extra => fireBall.efecto(extra)})})
		arrows.forEach({ arrow => game.whenCollideDo(arrow, { extra => arrow.efecto(extra)})})
		
	}
	
	method configurarAcciones(personaje) {
		enemigosMovimiento.forEach({ enemigo => game.onTick(1000, "Enemigo Moviendose", { enemigo.cambiarPosicionEnX(18.randomUpTo(24))})})
		fireBalls.forEach({ fireBall => game.onTick(fireBall.velocidad(), "FireBall Moviendose", { fireBall.moverFireBall()})})
		arrows.forEach({ arrow => game.onTick(arrow.velocidad(), "Arrow Moviendose", { arrow.moverArrow()})})
				
		game.onTick(500, "GAMEOVER", { if (personaje.morir()) gameOver.mostrarPantallaGameOver() })
		game.onTick(500, "GANAR JUEGO", {if (!game.hasVisual(bossVampiro)) victoria.mostrarPantallaVictoria() })
		game.onTick(500, "ABRIR PUERTAS BOSS", {if (!game.hasVisual(guardian)) [puertaDerechaBoss, puertaIzquierdaBoss].forEach({ puerta => puerta.abreteSesamo() })})
		
	}

}

object restauradorNivel {
	
	var enemigosEliminados = []
	
	method removerEnemigosEliminados() {
		enemigosEliminados.forEach({ enemigo => game.removeVisual(enemigo) })
	}
	
	method agregarEnemigoEliminado(enemigo) {
		enemigosEliminados.add(enemigo)
	}
	
	method restaurarInventario(personaje) {
		personaje.items().forEach({ item => personaje.posicionEnInventario(item, 0) })
	}
	
	method restaurarNivel(personaje, enemigo) {
		nivel.disenioNivel()
		nivel.agregarPersonajes(personaje)
		self.restaurarInventario(personaje)
		self.agregarEnemigoEliminado(enemigo)
		self.removerEnemigosEliminados()
		config.configurarAcciones(personaje)
		config.configurarTeclas(personaje)
		config.configurarColisiones(personaje)
	}
	
}

object interfazPelea {
	
	method iniciar(personaje,enemigo) {
		game.clear()
		self.dibujarInterfaz(personaje,enemigo)
		config.configurarTeclasCombate(personaje,enemigo)
		
		game.onTick(500, "BATTLE WON", { if (enemigo.morir()) self.finalizar(personaje, enemigo) })
		game.onTick(500, "GAMEOVER", { if (personaje.morir()) gameOver.mostrarPantallaGameOver() })
		
	}
	
	method finalizar(personaje,enemigo) {
		game.clear()
		restauradorNivel.restaurarNivel(personaje,enemigo)

	}
	
	method dibujarInterfaz(personaje,enemigo) {
		game.addVisualIn(fondo, game.origin())
		enemigo.modificarImagen()
		game.addVisualIn(personaje, game.at(7,4))
		game.addVisualIn(enemigo, game.at(15,0)) // 15,4
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

object victoria {
	
	method mostrarPantallaVictoria() {
		game.clear()
		game.addVisualIn(fondoVictoria, game.origin())
		game.addVisualIn(poro, game.at(15,1))
	}
}

