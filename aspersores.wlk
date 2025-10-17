import wollok.game.*
import cultivos.*
import personaje.*
import mercados.*

class Aspersor {
        var  property position
         const image = "aspersor.png"
   
     method esRegable(){
        return false
    }
    method image(){
        return image
    }
    method position(){
        return position
       }
    method comenzarARegar(){
        game.onTick(1000, "Riego Automatico",{ self.regarPosicionesLindantes()})
    }
    method regarPosicionesLindantes() {
           const posicionesARegar = self.posicionesVecinas()
           posicionesARegar.forEach({ posicionARegar => self.riegoAutomaticoEn(posicionARegar)})
     }    
    method riegoAutomaticoEn(posicion){
         if (cultivos.hayCultivoEn(posicion)) {
                const cultivoARegar = cultivos.cultivoEn(posicion)
                 if (cultivoARegar.esRegable()) {
                     cultivoARegar.regar()
                 }
         }
    }
    method posicionesVecinas(){
         const x = position.x()
         const y = position.y()
         const posicionesLindantes = #{  game.at(x, y + 1),          // arriba
                                         game.at(x + 1, y + 1),      // arribe a la derecha
                                         game.at(x + 1, y),          // derecha
                                         game.at(x + 1, y - 1),      // abajo a la derecha
                                         game.at(x, y - 1),          // abajo
                                         game.at(x - 1, y - 1),      // abajo a la izquierda
                                         game.at(x - 1, y),          // izquierza 
                                         game.at(x - 1, y + 1)       // arriba a la izquierda
                                         }
         return posicionesLindantes 
     }
}
object aspersores{
	 const aspersoresColocados = #{}
	
     method colocarAspersor(posicion){
        const aspersorAColocar = new Aspersor(position = posicion)
        aspersoresColocados.add(aspersorAColocar)
        game.addVisual(aspersorAColocar)
        aspersorAColocar.comenzarARegar()
        }
       method hayAspersorEn(posicion){
		 return aspersoresColocados.any({aspersor => aspersor.position() == posicion})
	}
	method aspersorEn(posicion){
		 return aspersoresColocados.find({aspersor => aspersor.position() == posicion})
	 }
       method aspersoresColocados(){
              return aspersoresColocados
       }
}



