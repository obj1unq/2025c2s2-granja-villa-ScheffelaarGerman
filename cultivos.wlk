import wollok.game.*
import granja.*
import personaje.*
import extras.*

class Maiz {
    var position
    var esBebe = true

    method image() {
        if (esBebe) {
            return "corn_baby.png"
        } else {
            return "corn_adult.png"
        }
    }

    method position() { return position }
    
	method position(nuevaPosicion) { position = nuevaPosicion }

    method regar() {
        if (esBebe) { 
            esBebe = false
        }
    }

    method estaListoParaCosechar() {
        return !esBebe
    }

    method vender() {
        const valorPorPlanta = 150
        personaje.sumarMonedas(valorPorPlanta)
        granja.removerCosecha(self)
    }

	method esRegable() { return true }


}

class Trigo {
    var position
    var etapa = 0

    method image() {
        return "wheat_" + etapa + ".png"
    }

    method position() { return position }
   
    method position(nuevaPosicion) { position = nuevaPosicion }

    method regar() {
        if (etapa < 3) {
            etapa += 1
        } else {
            etapa = 0
        }
    }

    method estaListoParaCosechar() {
        return etapa >= 2
    }

    method vender() {
        var valorPorPlanta
        if (etapa == 2) {
            valorPorPlanta = 100
        } else {
            valorPorPlanta = 200
        }
        personaje.sumarMonedas(valorPorPlanta)
        granja.removerCosecha(self)
    }

	method esRegable() { return true }


}
class Tomaco {
    var position

    method image() { return "tomaco.png"}

    method position() { return position }
   
    method position(nuevaPosicion) { position = nuevaPosicion }

        method regar() {
        const parcelaACrecer =
            if (position.y() == game.height() - 1) {
                game.at(position.x(), 0)
            } else {
                position.up(1)
            }
        if (granja.esParcelaDisponible(parcelaACrecer)) {
            const nuevoTomaco = new Tomaco(position = parcelaACrecer)
            granja.agregarCultivo(nuevoTomaco)
        }
    }


    method estaListoParaCosechar() {
        return true
    }

    method vender() {
        const valorPorPlanta = 80
        personaje.sumarMonedas(valorPorPlanta)
        granja.removerCosecha(self)
    }

	method esRegable() { return true }


}
