import wollok.game.*
import granja.*
import personaje.*

class Maiz {
	var position
	var esBebe = true
	
	method image(){
		 if (esBebe){
			return "corn_baby.png"
		 } else {
			return "corn_adult.png"
		 }
	}
	
	method position() { return position }

	method position(nuevaPosicion) { position = nuevaPosicion}

	method regar(){
		if ( esBebe) { esBebe= false}
	}

}


class Trigo {
	var position
	var etapa = 0
	
	method image() {return "wheat_" + etapa + ".png"}

	method position() { return position}

	method position(nuevaPosicion) { position = nuevaPosicion}

	method regar() {
		if (etapa < 3){
			etapa += 1
		} else {
			etapa =0
		}

	}
}
class Tomaco {
	var position 
	
	method position() {return position 	}

	method position(nuevaPosicion) { position = nuevaPosicion}

	method image() {return "tomaco.png"}

	method regar(){
		const parcelaACrecer = if (position.y() == game.height() -1 ){
									game.at(position.x(), 0)
								}
								else{
									position.up(1)
								}
		if (!granja.hayCultivosEn(parcelaACrecer)){
			const nuevoTomaco = new Tomaco ( position = parcelaACrecer)
			granja.agregarCultivo(nuevoTomaco)
		}

	}

}