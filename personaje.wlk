import wollok.game.*
import cultivos.*
import aspersores.*
import mercados.*
//**  Personaje  **//
object personaje {
     var property position = game.center()
     const property image = "mplayer.png"
     const cultivosCosechados = #{}
     var monedas = 0
    
//**  Siembra  *//
    method sembrar(cultivo) {
         self.validarParcelaParaSiembra()
         cultivos.agregarCultivo(cultivo)
     }
    method validarParcelaParaSiembra(){  
         if (cultivos.hayCultivoEn(self.position())){
             self.error("Parcela ocupada")     
         }
    }
    method sembrarMaiz(){
         const maiz = new Maiz (position= self.position())
         self.sembrar(maiz)
    }
    method sembrarTrigo(){
         const trigo = new Trigo (position= self.position())
         self.sembrar(trigo)
    }
    method sembrarTomaco() {
         const tomaco = new Tomaco(position = self.position())
         self.sembrar(tomaco)
}

//**  Riego  **//
    method regar() {
         self.validarParcelaParaRiego()
         const cultivoARegar = cultivos.cultivoEn(self.position())
         cultivoARegar.regar()
     }
    method validarParcelaParaRiego(){
         if (!cultivos.hayCultivoEn(self.position())){
             self.error("Nada para regar aca")
         }
     }
    method esRegable(){
         return false 
    }
//**  Cosecha  **//
    method cosechar() {
         self.validarParcelaParaCosecha()
         self.validarEstadoDeCultivoParaCosecha()
         const cultivoACosechar = cultivos.cultivoEn(self.position())
         cultivosCosechados.add(cultivoACosechar)
         cultivos.eliminarCultivo(cultivoACosechar)
     }
    method validarParcelaParaCosecha(){
         if (!cultivos.hayCultivoEn(self.position())){
             self.error("Nada para cosechar aca")
         }
     }    
    method validarEstadoDeCultivoParaCosecha(){    
      const cultivoACosechar = cultivos.cultivoEn(self.position())
      if (!cultivoACosechar.estaListoParaCosechar()) {
         self.error("No se puede cosechar aún.")
         }
     }
    method vaciarCosecha(){
     cultivosCosechados.clear()
    }
//**  Venta  **//
    method vender() {
         self.validarLugarDeVenta()
         self.validarCosechaParaVenta()
         const mercadoActual = mercados.mercadoEn(self.position())
         const cosechaAVender = cultivosCosechados
         mercadoActual.comprar(cosechaAVender, self)
    }
    method validarLugarDeVenta(){
         if (!self.estoyEnLugarDeVenta()){ 
             self.error("No es lugar de venta")
             }
    }
    method estoyEnLugarDeVenta() {
        return mercados.hayMercadoEn(self.position())
    }
   method validarCosechaParaVenta() {
      if (!self.hayCultivosCosechados()) {
          self.error("Nada para vender")
         } 
     }
     method hayCultivosCosechados() {
    return  cultivos.hayCultivoEn(position)
}

    method sumarMonedas(cantidad) {
        monedas +=  cantidad
    }
//**  Aspersor **//
    method colocarAspersor() {
     self.validarParcelaParaAspersor()
     const posicionAColocar = self.position()
     const nuevoAspersor = new Aspersor(position = posicionAColocar)
     aspersoresColocados.agregarAspersor(nuevoAspersor)
     }
    method validarParcelaParaAspersor() {
    if (aspersores.hayAspersorEn(self.position())) {
        self.error("Ya hay un aspersor aquí")
    } else if (cultivos.hayCultivoEn(self.position())) {
        self.error("Parcela ocupada")
    } else if (mercados.hayMercadoEn(self.position())) {
        self.error("No se puede colocar un aspersor en el mercado")
    }
}
//** Inventario  **//    
method inventario() {
         const plantasCosechadas = cultivosCosechados.size()
         game.say(self,"Monedas de Oro:"+monedas+"\n" +
                      "Plantas cosechadas:"+plantasCosechadas)
    }
}

