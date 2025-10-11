import wollok.game.*
import cultivos.*
import granja.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method sembrar(cultivo){
		if(!granja.hayCultivosEn(self.position())){
			granja.agregarCultivo(cultivo)
		} else {
			self.error("Parcela Ocupada")
		}
	}
	method sembrarMaiz(){
		const maiz = new Maiz (position= self.position())
		self.sembrar(maiz)
	}

	method sembrarTrigo(){
		const trigo = new Trigo (position = self.position())
		self.sembrar(trigo)
	}
	method sembrarTomaco() {
		const tomaco = new Tomaco (position = self.position())
		self.sembrar(tomaco)
	}

	method regar() {
    	const cultivosARegar = granja.cultivosEn(self.position())
    	if (granja.hayCultivosEn(self.position())) {
        	cultivosARegar.forEach({cultivo => cultivo.regar()})
		}
		else{
		self.error("Parcela Vacia")
    	}
	}
}