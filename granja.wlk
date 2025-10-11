import wollok.game.*
import personaje.*
import cultivos.*

object granja {
    var cultivos = #{}
    var cosecha = #{}
    
    method cultivosSembrados() = cultivos
    
    method hayCultivosEn(posicion) = cultivos.any({cultivo => cultivo.position() == posicion})
    
    method cultivosEn(posicion) = cultivos.filter({cultivo => cultivo.position() == posicion})
    
    method agregarCultivo(nuevoCultivo) {
        cultivos.add(nuevoCultivo)
        game.addVisual(nuevoCultivo)
    }
    
     method cosechar(cultivo) {
            cosecha.add(cultivo)
            cultivos.remove(cultivo)
            game.removeVisual(cultivo)
    }
}
