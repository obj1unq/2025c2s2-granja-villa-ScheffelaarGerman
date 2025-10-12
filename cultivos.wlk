import wollok.game.*
import granja.*
import personaje.*
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
}
class Tomaco {
    var position

    method position() { return position }
    method position(nuevaPosicion) { position = nuevaPosicion }

    method image() { return "tomaco.png" }

    method regar() {
        const parcelaACrecer = 
            if (position.y() == game.height() - 1) {
                game.at(position.x(), 0)
            } else {
                position.up(1)
            }

        if (!granja.hayCultivoEn(parcelaACrecer)) {
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
}
