import wollok.game.*
import personaje.*
import cultivos.*

object granja {
    var cultivos = #{}
    
    method cultivosSembrados() = cultivos
    
    method hayCultivosEn(posicion) = cultivos.any({cultivo => cultivo.position() == posicion})
    
    method cultivosEn(posicion) = cultivos.filter({cultivo => cultivo.position() == posicion})
    
    method agregarCultivo(nuevoCultivo) {
        cultivos.add(nuevoCultivo)
        game.addVisual(nuevoCultivo)
    }
    
    method removerCultivo(cultivoASacar) {
        cultivos.remove(cultivoASacar)
        game.removeVisual(cultivoASacar)
    }
}

