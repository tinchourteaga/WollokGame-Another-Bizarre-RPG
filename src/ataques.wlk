import wollok.game.*
import personajes.*
import enemigos.*

class Ataque {
	var property danio = 0
	
	method ataque(personaje)
}

object robarItemConMasPoder inherits Ataque {
	
	override method ataque(personajeAfectado) {
		personajeAfectado.items().remove(self.itemConMasPoder(personajeAfectado))
	}
	
	method itemConMasPoder(personaje) {
		return personaje.items().max({item => item.poder()})
	}
}

object robarItemEnMano inherits Ataque {
	
	override method ataque(personaje) {
		
		personaje.ponerItemSiguienteEnMano()	
	}
}

// ATAQUES

object ataqueBasico {
	
	method efecto(caster,target) {
		target.disminuirVida(caster.fuerza())
	}
}

object absorberVida {
	
	method efecto(caster,target) {
		target.disminuirVida(20)
		caster.aumentarVida(20)
	}
}

object incinerar {
	
	method efecto(caster,target) {
		target.status(incinerado)
	}
}

// STATUS EFFECTS

class StatusEffect {
	
	var turnosConEfecto = 0
	var duracion
	
	method efecto(target) {
		turnosConEfecto++
	}
	
	method efectoPorturno(target) {
		if(turnosConEfecto < duracion)
		{
			self.efecto(target)
		} else {
			target.statusEffect(ninguno)
			turnosConEfecto = 0
		}
	}
}

object ninguno inherits StatusEffect {
	
	override method efectoPorTurno(target) {
		// No hace nada
	}
}

object incinerado inherits StatusEffect { 
	
	var duracion = 3
	
	override method efecto(target) {
		target.disminuirVida(25)
		super()
	}
}










