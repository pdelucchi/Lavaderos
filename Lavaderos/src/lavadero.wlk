class Ave {
	method ensuciar(unVehiculo){
		unVehiculo.ensuciarse(10)
	}

}



class Paloma inherits Ave {
	var peso
	
	constructor(unPeso){
		peso = unPeso
	}
	
	override method ensuciar(unVehiculo){
		var suciedad = peso * 0.3
		unVehiculo.ensuciarse(suciedad)
		peso -= suciedad
	}
} 

class Gaviota inherits Ave{
	var pescadosComidos
	
	constructor(_pescadosComidos){
		pescadosComidos = _pescadosComidos
	}
	override method ensuciar(unVehiculo){
		var suciedad = pescadosComidos * 3
		unVehiculo.ensuciarse(suciedad)
	}
}

class Bandada{
	var listaDeAves = []
	var formacion
	constructor(_listaDeAves,_formacion){
		listaDeAves = _listaDeAves
		formacion = _formacion
	}
	method cambiarFormacion(nuevaFormacion){
		formacion = nuevaFormacion
	}
	method ensuciar(unVehiculo){
		formacion.ensuciar(self,unVehiculo)
	}
	method avesPertenecientesALaBandada(){
		return listaDeAves
	}
}

class FormacionEnV{
	method ensuciar(unaBandada,unVehiculo){
		unaBandada.avesPertenecientesALaBandada().forEach({ave => ave.ensuciar(unVehiculo)})
	}
}

object formacionEnW inherits FormacionEnV{
	override method ensuciar(unaBandada,unVehiculo){
		super(unaBandada,unVehiculo)
		super(unaBandada,unVehiculo)
		
	}
}

object formacionEnI{
	method ensuciar(unaBandada,unVehiculo){
			unaBandada.avesPertenecientesALaBandada().head().ensuciar(unVehiculo)
			unaBandada.avesPertenecientesALaBandada().last().ensuciar(unVehiculo)
	}
}

class LluviaDeCenizaVolcanica{
	var milimetrosDeLluvia
	constructor(_milimetrosDeLluvia){
		milimetrosDeLluvia = _milimetrosDeLluvia
	}
	/* 
	method ensuciar(unVehiculo){
		unVehiculo.ensuciarse(milimetrosDeLluvia)
	}*/
	method caerSobre(lugar){
		lugar.listaDeVehiculos().forEach({vehiculo => vehiculo.ensuciarse(milimetrosDeLluvia)})
}

}

class Vehiculo {
	var nivelDeSuciedad = 0
	
	method ensuciarse(suciedad){
		nivelDeSuciedad += suciedad
	}
	
	method limpiar(){
		nivelDeSuciedad = 0
	}
	
	method nivelDeSuciedad(){
		return nivelDeSuciedad
	}
	method irAlMasBarato(lugar){
		var lavaderoElegido = lugar.lavaderoMasBaratoPara(self)
		lavaderoElegido.lavar(self)
	}
}


class Lugar {
	var listaVehiculos = []
	var listaLavaderos = []
	constructor(listaDeLavaderos){
		listaLavaderos = listaDeLavaderos
	}
	method recibirVehiculo(unVehiculo){
		listaVehiculos.add(unVehiculo)
	}
	method listaDeVehiculos(){
		return listaVehiculos
	}
	method agregarLavadero(lavadero){
		listaLavaderos.add(lavadero)
	}
	method listaDeLavaderos(){
		return listaLavaderos
	}
	method lavaderoMasBaratoPara(unAuto){
		return listaLavaderos.min({lavadero=> lavadero.precioLavado(unAuto)})
	}
}

class Lavadero{
	method lavar(unVehiculo){
		unVehiculo.limpiar()
	}
}

class LavaderoAutomatico inherits Lavadero{
	var precio
	var tiempo
	
	constructor(unTiempo, unPrecio){
		precio = unPrecio
		tiempo = unTiempo
	}
	
	method precioLavado (unVehiculo){
		return precio
	}
	
	method tiempoLavado (unVehiculo){
		return tiempo
	}
}

class LavaderoArtesanal inherits Lavadero{
	var cantidadPersonas
	var costoUnitarioPorMinuto
	constructor(_cantidadPersonas, _costoUnitarioPorMinuto){
		cantidadPersonas = _cantidadPersonas
		costoUnitarioPorMinuto = _costoUnitarioPorMinuto
	}
	method precioLavado (unVehiculo){
		return cantidadPersonas * self.tiempoLavado(unVehiculo) * costoUnitarioPorMinuto
	}
	method tiempoLavado (unVehiculo){
		return unVehiculo.nivelDeSuciedad()/5
	}
}

