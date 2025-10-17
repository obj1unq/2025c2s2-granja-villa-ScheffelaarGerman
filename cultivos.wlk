import wollok.game.*
import personaje.*
import aspersores.*
import mercados.*
//** Cultivos **//
object cultivos {
    const cultivosSembrados = #{}
  
    method agregarCultivo(cultivo) {
         cultivosSembrados.add(cultivo)
         game.addVisual(cultivo)
    }
    method eliminarCultivo(cultivo) {
         cultivosSembrados.remove(cultivo)
         game.removeVisual(cultivo)
     }
    method hayCultivoEn(posicion) {
         return cultivosSembrados.any({ cultivo => cultivo.position() == posicion })
     }
    method cultivoEn(posicion){
         return cultivosSembrados.find({ cultivo => cultivo.position() == posicion })
     }
    method vaciarCultivosSembrados(){
         cultivosSembrados.clear()
     }
}
//** Maiz **//
class Maiz {
    var property position
    var etapa = maizBebe

    method sembrarCultivo(posicion){
         position = posicion
         cultivos.agregarCultivo(self)
    }
    method image(){
         return etapa.image()
     }
    method estaListoParaCosechar(){
         return etapa.estaListoParaCosechar() 
     }
    method cosechar(){
         cultivos.eliminarCultivo(self) 
     }
    method valorDeVenta(){
         return etapa.valorDeVenta()
     }
    method regar(){
         etapa = etapa.siguienteEstado()
     }
     method esRegable(){
         return true
     }
}
object maizBebe {
    method image() { return "corn_baby.png" }

    method siguienteEstado() { return maizAdulto }

    method estaListoParaCosechar() { return false }

    method valorDeVenta() { return 0 }
}

object maizAdulto {
    method image(){
         return "corn_adult.png"
     }

    method siguienteEstado(){
         return self
     }
    method estaListoParaCosechar(){
         return true
     }
    method valorDeVenta(){
         return 150
     }

}
//** Trigo **//
 class Trigo {
    var property position
    var etapa = trigoEtapa0
   
    method sembrarCultivo(posicion){
         position = posicion
         cultivos.agregarCultivo(self)
     }
    method image(){
         return etapa.image()
     }
    method regar(){
         etapa = etapa.siguienteEstado()
     }
    method estaListoParaCosechar(){
         return etapa.estaListoParaCosechar()
     }
    method cosechar(){
         cultivos.eliminarCultivo(self)
     }
    method valorDeVenta(){
         return etapa.valorDeVenta()
     }
     method esRegable(){
         return true 
     }
}
object trigoEtapa0{
    method image(){
         return "wheat_0.png"
     }
    method siguienteEstado(){
        return trigoEtapa1
     }
    method estaListoParaCosechar(){
         return false
     }
    method valorDeVenta(){
         return 0
     }
}
object trigoEtapa1{
    method image(){
         return "wheat_1.png"
     }
    method siguienteEstado(){
         return trigoEtapa2
     }
    method estaListoParaCosechar(){
         return false
     }
    method valorDeVenta(){
         return 0
     }
}
object trigoEtapa2{
    method image(){
         return "wheat_2.png"
     }
    method siguienteEstado(){
         return trigoEtapa3
     }
    method estaListoParaCosechar(){
          return true
     }
    method valorDeVenta(){
         return 100
     }
}
object trigoEtapa3{
    method image(){
         return "wheat_3.png"
     }
    method siguienteEstado(){
         return trigoEtapa0
    } 
    method estaListoParaCosechar(){
         return true
     }
    method valorDeVenta(){
         return 200
     }
}
//** Tomaco **//
class Tomaco {
     var property position
     const image = "tomaco.png"
    
    method image(){
        return image
    }
    method sembrarCultivo(posicion){
         position = posicion
         cultivos.agregarCultivo(self)
     }
    method regar() {
        if (position.y() == game.height() - 1) {
             position = game.at(position.x(), 0)
         } else {
             position = game.at(position.x(), position.y() + 1)
         }
     }
    method estaListoParaCosechar(){
         return true
     }
    method cosechar(){
         cultivos.eliminarCultivo(self)
     }
    method valorDeVenta(){
         return 80
     }
     method esRegable() {
         return true
     }
}