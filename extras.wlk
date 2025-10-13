import wollok.game.*
import granja.*
import cultivos.*
import personaje.*

class Aspersor {
    var  property position

    method image() { return "aspersor.png" }

    method esRegable() { return false }

    method comenzarARegar(){
        game.onTick(1000, "Riego Automatico",{ self.regarPosicionesLindantes()})
    }
    

    method regarPosicionesLindantes() {
        const posicionesARegar = self.posicionesVecinas()

        posicionesARegar.forEach({ posicionARegar =>
            if (granja.hayCultivoEn(posicionARegar)) {
                const cultivoARegar = granja.cultivoEn(posicionARegar)
                if (cultivoARegar.esRegable()) {
                    cultivoARegar.regar()
                }
            }
        })
    }

    method posicionesVecinas(){
        const x = position.x()
        const y = position.y()
        const posicionesLindantes = #{
            game.at(x, y + 1),      
            game.at(x + 1, y + 1),  
            game.at(x + 1, y),      
            game.at(x + 1, y - 1),  
            game.at(x, y - 1),     
            game.at(x - 1, y - 1),  
            game.at(x - 1, y),      
            game.at(x - 1, y + 1)   
        }
   return posicionesLindantes.filter({ posicionLindante => self.esPosicionDentroDelTablero(posicionLindante) })
    }

    method esPosicionDentroDelTablero(posicion){
        return posicion.x() >= 0 && posicion.x() < game.width() &&
               posicion.y() >= 0 && posicion.y() < game.height()
    }
}
    