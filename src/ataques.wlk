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

object garrotazo {
	
	method efecto(caster,target) {
		target.disminuirVida(caster.fuerza() + caster.pesoGarrote())
	}
}

object aplastar {
	
	method efecto(caster,target) {
		target.disminuirVida(target.items().size() * 100)
	}
}

object mordidaDeFuego {
	
	method efecto(caster,target) {
		target.disminuirVida(100)
		target.statusEffect(incinerado)
	}
}

object absorberVida {
	
	method efecto(caster,target) {
		target.disminuirVida(100)
		caster.aumentarVida(250)
	}
}

object incinerar {
	
	method efecto(caster,target) {
		target.statusEffect(incinerado)
	}
}

object envenenar {
	
	method efecto(caster,target) {
		target.statusEffect(envenenado)
	}
}

object electrocutar {
	
	method efecto(caster,target) {
		target.statusEffect(mareado)
	}
}

object debilitar {
	
	method efecto(caster,target) {
		target.disminuirFuerza(20)
	}
}

object buffearse {
	
	method efecto(caster,target) {
		caster.aumentarFuerza(50)
	}
}

object festinDeSangre {
	
	method efecto(caster,target) {
		caster.aumentarVida(500)
		caster.aumentarFuerza(100)
	}
}
 

// STATUS EFFECTS

class StatusEffect {
	
	var property turnosConEfecto = 0
	
	method efecto(target) {
		turnosConEfecto++
	}
	
	method efectoPorTurno(target) {
		if(turnosConEfecto == 3)
		{
			turnosConEfecto = 0
			target.statusEffect(ninguno)
			
		} else {
			self.efecto(target)
		}
	}
}

object ninguno inherits StatusEffect {
	
	override method efectoPorTurno(target) {
		// No hace nada
	}
}

object incinerado inherits StatusEffect { 
	
	override method efecto(target) {
		super(target)
		target.disminuirVida(50)
	}
}

object envenenado inherits StatusEffect {
	
	override method efecto(target) {
		super(target)
		target.disminuirVida(self.turnosConEfecto() * 20)
		
	}
}

object mareado inherits StatusEffect {
	
	override method efecto(target) {
		super(target)
		target.disminuirVida(target.fuerza())
	}
}









