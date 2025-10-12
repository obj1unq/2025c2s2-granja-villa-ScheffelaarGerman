import wollok.game.*
import personaje.*
import cultivos.*

object granja {
    var cultivos = #{}
    var cosecha = #{}
    
    method cultivosSembrados() = cultivos
   
    method cultivosCosechados() = cosecha

    method hayCultivoEn(posicion) = cultivos.any({ cultivo => cultivo.position() == posicion })
   
    method cultivoEn(posicion) = cultivos.find({ cultivo => cultivo.position() == posicion })

    
 method agregarCultivo(nuevoCultivo) {
        cultivos.add(nuevoCultivo)
        game.addVisual(nuevoCultivo)
    }

    method cosechar(cultivo) {
        cosecha.add(cultivo)
        cultivos.remove(cultivo)
        game.removeVisual(cultivo)
    }

    method removerCosecha(unaPlanta) {
        cosecha.remove(unaPlanta)
    }
}


object market {
    var property position = game.at(0, 0)
    method image() { return "market.png" }
}
