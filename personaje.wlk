import wollok.game.*
import cultivos.*
import granja.*

object personaje {
    var property position = game.center()
    const property image = "mplayer.png"

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
        if (!granja.hayCultivosEn(self.position())) {
            granja.agregarCultivo(cultivo)
        } else {
            game.say(self,"Parcela Ocupada")
        }
    }

    method regar() {
        const cultivosARegar = granja.cultivosEn(self.position())
        if (!granja.hayCultivosEn(self.position())) {
            game.say(self,"Parcela Vacia")
        }
        cultivosARegar.forEach({ cultivo => cultivo.regar() })
    }

    method cosechar() {
        const cultivosACosechar = granja.cultivosEn(self.position())
        if (!granja.hayCultivosEn(self.position())) {
            game.say(self,"Nada para Cosechar")
        }
        cultivosACosechar.forEach({ cultivo =>
            if (cultivo.estaListoParaCosechar()) {
                granja.cosechar(cultivo)
            }else{
				game.say(self, "No se puede Cosechar aun.")
			}
        })
    }
}