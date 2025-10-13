import wollok.game.*
import personaje.*
import cultivos.*
import extras.*


object granja {
    var cultivos = #{}
    var cosecha = #{}
    var aspersores = #{}
    
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
    
    method esTierraFertil(posicion) {
        return posicion != market.position()
    }

    method esParcelaDisponible(posicion) {

        return self.esTierraFertil(posicion) && !self.hayCultivoEn(posicion) && !self.hayAspersorEn(posicion)
    }

    method esRegable() { return false }

    method hayAspersorEn(posicion){
        return aspersores.any({aspersor => aspersor.position() == posicion})
    }

    method agregarAspersor(unAspersor){
        aspersores.add(unAspersor)
        game.addVisual(unAspersor)

    }
}


object market {
    var property position = game.at(0, 0)
    
    method image() { return "market.png" }

    method esRegable() { return false }

}
