import wollok.game.*
import cultivos.*
import granja.*
import extras.*

object personaje {
    var property position = game.center()
    const property image = "mplayer.png"
    var property monedasDeOro = 0
    
     method sembrarMaiz() {
        const maiz = new Maiz(position = self.position())
        self.sembrar(maiz)
    }

    method sembrarTrigo() {
        const trigo = new Trigo(position = self.position())
        self.sembrar(trigo)
    }

    method sembrarTomaco() {
        const tomaco = new Tomaco(position = self.position())
        self.sembrar(tomaco)
    }

    method sembrar(cultivo) {
        self.validarParcelaParaSiembra()
        granja.agregarCultivo(cultivo)
    }

    method validarParcelaParaSiembra() {
    if (!granja.esTierraFertil(self.position())) {
        self.error("No es tierra fértil")
    }

    if (granja.hayCultivoEn(self.position())) {
        self.error("Parcela ocupada")
    }
}



    method regar() {
        if (!granja.hayCultivoEn(self.position())) {
            self.error("Parcela vacía")
        }
        const cultivo = granja.cultivoEn(self.position())
        cultivo.regar()
    }

    method cosechar() {
        if (!granja.hayCultivoEn(self.position())) {
            self.error("Nada para cosechar")
        }

        const cultivo = granja.cultivoEn(self.position())

        if (cultivo.estaListoParaCosechar()) {
            granja.cosechar(cultivo)
        } else {
            self.error("No se puede cosechar aún.")
        }
    }



        method vender() {
        self.validarLugarDeVenta()

        if (!self.hayCultivosCosechados()) {
            self.error("Nada para vender")
        }

        const cosechaAVender = granja.cultivosCosechados()
        cosechaAVender.forEach({ cultivoCosechado =>
            self.venderCultivo(cultivoCosechado)
        })
    }

    method validarLugarDeVenta() {
        if (!self.estoyEnLugarDeVenta()) {
            self.error("Nada que vender acá")
        }
    }

    method estoyEnLugarDeVenta() {
        return self.position() == market.position()
    }

    method hayCultivosCosechados() {
        return !granja.cultivosCosechados().isEmpty()
    }

    method venderCultivo(unCultivo) {
        unCultivo.vender()
    }

    method sumarMonedas(cantidad) {
        monedasDeOro = monedasDeOro + cantidad
    }

    method inventario() {
        const plantasCosechadas = granja.cultivosCosechados().size()
        game.say(self, 
            "Monedas de Oro: " + monedasDeOro +  "\n"  +
            "Plantas cosechadas: " + plantasCosechadas
        )
    }

    method esRegable() { return false }

    method colocarAspersor() {
    const posActual = self.position()

    if (granja.hayAspersorEn(self.position())) {
        self.error("Ya hay un aspersor aca ")
    } else if (granja.hayCultivoEn(posActual)) {
        self.error("Parcela ocupada")
    } else {
        const nuevoAspersor = new Aspersor(position = self.position())
        granja.agregarAspersor(nuevoAspersor)
        nuevoAspersor.comenzarARegar()
    }
}

    
}
