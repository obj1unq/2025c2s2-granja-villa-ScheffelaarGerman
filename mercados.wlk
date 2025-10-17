import wollok.game.*
import personaje.*
import cultivos.*
import aspersores.*
class Market {
    var property position
    const image = "market.png"
    var property monedas
    var stock = #{}

    method image(){
        return image
     }
    method esRegable(){
         return false
     }
    method puedeComprar(cosecha) {
         const valorTotalDeCosecha = self.valorTotalDeLaCosecha(cosecha)
         return monedas >= valorTotalDeCosecha
     }
    method valorTotalDeLaCosecha(cosecha) {
         const valorTotalDeLaCosecha = cosecha.sum({ cultivo => cultivo.valorDeVenta() })
         return valorTotalDeLaCosecha
    }
    method comprar(cosecha, vendedor) {
         self.validarCompraDeCosecha(cosecha) 
         const valorTotalDeCosecha = self.valorTotalDeLaCosecha(cosecha)
          self.recibirMercaderiaDe(cosecha)
          self.pagarMercaderiaPor(valorTotalDeCosecha, vendedor)
         vendedor.vaciarCosecha()
         game.say(vendedor,"Venta Exitosa")
        } 
    method validarCompraDeCosecha(cosecha){
        if (!self.puedeComprar(cosecha)){
            self.error("No hay suficiente dinero para comprar la cosecha entera")
        }
    }
    method recibirMercaderiaDe(cosecha) {
         stock = stock.union(cosecha)
    }
    method pagarMercaderiaPor(valor, vendedor) {
         monedas -= valor
         vendedor.sumarMonedas(valor)
    }
    
}
object mercados{
	 const mercadosInstalados = #{}

	method agregarMercado(posicion, dinero){
		 const nuevoMercado = new Market (position = posicion, monedas = dinero)
		 game.addVisual(nuevoMercado)
		 mercadosInstalados.add(nuevoMercado)
	 }
method hayMercadoEn(posicion) {
    return mercadosInstalados.any({ mercado =>
        mercado.position() == posicion
    })
}


method mercadoEn(posicion) {
    return mercadosInstalados.find({ mercado =>
        mercado.position() == posicion
    })
}


method colocarMercados() {
     const mercado1 = new Market(position = game.at(0, 0), monedas = 10)        
     const mercado2 = new Market(position = game.at(9, 0), monedas = 100)     
     const mercado3 = new Market(position = game.at(0, 9), monedas = 500)       
     const mercado4 = new Market(position = game.at(9, 9), monedas = 1000)   
     game.addVisual(mercado1)
     game.addVisual(mercado2)
     game.addVisual(mercado3)
     game.addVisual(mercado4)
    mercadosInstalados.addAll(#{ mercado1, mercado2, mercado3, mercado4 })
}
}