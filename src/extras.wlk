import wollok.game.*
import personajes.*

class Muro {
	var atravesable = false
		
	method esAtravesable() = atravesable

	method image()
}

object muroVertical inherits Muro {
	override method image() = "muroVertical.png" //Hay que achicar la img
	
	method generarMuroVertical() {
		const posicionesParaGenerarMuros = [game.at(0,5),game.at(5,0)] // A manopla o hay alguna forma mas eficiente que no veo??
   		posicionesParaGenerarMuros.forEach {posicion => game.addVisualIn(self,posicion)}
   	}

object muroHorizontal inherits Muro {
	override method image() = "muroHorizontalResized.png" //Hay que achicar la img
	
	method generarMuroHorizontal() {
   		const posicionesParaGenerarMuros = [game.at(3,4),game.at(0,0)] // A manopla o hay alguna forma mas eficiente que no veo??
   		posicionesParaGenerarMuros.forEach {posicion => game.addVisualIn(self,posicion)}
   		
		
	}
}


object arriba {
	method posicionEnEsaDireccion() = scorpion.position().up(1)
}

object abajo {
	method posicionEnEsaDireccion() = scorpion.position().down(1)
}

object derecha {
	method posicionEnEsaDireccion() = scorpion.position().right(1)
}

object izquierda {
	method posicionEnEsaDireccion() = scorpion.position().left(1)
}