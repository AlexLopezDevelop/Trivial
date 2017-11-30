//
//  ViewController.swift
//  Trivial
//
//  Created by Alex Lopez on 6/11/17.
//  Copyright © 2017 Alex Lopez. All rights reserved.
//

import UIKit
import AVFoundation //Music

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var labelPregunta: UILabel!
    @IBOutlet weak var question1: UIButton!
    @IBOutlet weak var question2: UIButton!
    @IBOutlet weak var question3: UIButton!
    @IBOutlet weak var question4: UIButton!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var fin: UILabel!
    @IBOutlet weak var pointsLable: UILabel!
    //-------------------------------------------
    var temas = ["Java","PHP","BBDD"]
    var preguntasJavaCollection = [Preguntas]()
    var preguntasPHPCollection = [Preguntas]()
    var preguntasSwiftCollection = [Preguntas]()
    var preguntasBBDDCollection = [Preguntas]()
    //-------------------------------------------
    var player:AVAudioPlayer = AVAudioPlayer()//Creamos el reproductor
    var temaSeleccionado = ""
    var preguntasSelect = [String]()
    var questions = [UIButton]()
    var shuffled = [String]()
    var respuesta = ""
    var pregSeleccionada = ""
    var points = 0
    
    //Empieza el codigo --------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        musicOn()
        fin.isHidden = true;
        pickerView.dataSource = self
        pickerView.delegate = self
        questions = [question1,question2,question3,question4]
        iniciarPreguntas()
        offButtons()
        temaSeleccionado = "Java"
        pointsLable.text = "Points: \(points)"
    }
    
    //Funcion para ver que boton a pulsado el jugador ------------------------------------------------------------------
    @IBAction func buttonPlay(_ sender: UIButton) {
        if sender.currentTitle == respuesta{
            sender.backgroundColor = UIColor.green
            points = points + 1
            pointsLable.text = "Points: \(points)"
        }else{
            sender.backgroundColor = UIColor.red
        }
        offButtons()
        play.isEnabled = true
        pickerView.dataSource = self
        if temas.isEmpty {
            play.isEnabled = false
            pickerView.isHidden = true
            fin.isHidden = false
        }
    }
    
    //Funcion del boton play --------------------------------------------------------------------------------------------
    @IBAction func play(_ sender: Any) {
        onButtons()
        play.isEnabled = false
        preguntasSelect.removeAll()
        shuffled.removeAll()
        recogerDatos()
        shuffle()
        for i in 0..<questions.count{
            questions[i].backgroundColor = UIColor.orange
            questions[i].setTitle(shuffled[i], for: .normal)
        }
    }
    
    // Funcion que coge el array de respuestas y mezcla el contenido del array ------------------------------------------
    func shuffle(){
        for _ in 0..<preguntasSelect.count
        {
            let rand = Int(arc4random_uniform(UInt32(preguntasSelect.count)))
            shuffled.append(preguntasSelect[rand])
            preguntasSelect.remove(at: rand)
        }
    }
    
   // Funciones del pickerView ------------------------------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temaSeleccionado = temas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return temas[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temas.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Funcion que recoge los datos y los guarda -----------------------------------------------------------------------
    func recogerDatos(){
        switch temaSeleccionado {
        case "Java":
            if preguntasJavaCollection.count == 1{
                var position = 0
                for i in 0..<temas.count {
                    if temas[i] == "Java"{
                        position = i
                    }
                }
                temas.remove(at: position)
                forceRow()
            }
            let rand = Int(arc4random_uniform(UInt32(preguntasJavaCollection.count)))
            labelPregunta.text = preguntasJavaCollection[rand].pregunta
            preguntasSelect = [preguntasJavaCollection[rand].respuestas[0],preguntasJavaCollection[rand].respuestas[1],preguntasJavaCollection[rand].respuestas[2],preguntasJavaCollection[rand].respuestas[3]]
            respuesta = preguntasJavaCollection[rand].rc
            preguntasJavaCollection.remove(at: rand)
            break
        case "PHP":
            if preguntasPHPCollection.count == 1{
                var position = 0
                for i in 0..<temas.count {
                    if temas[i] == "PHP"{
                        position = i
                    }
                }
                temas.remove(at: position)
                forceRow()
            }
            let rand = Int(arc4random_uniform(UInt32(preguntasPHPCollection.count)))
            labelPregunta.text = preguntasPHPCollection[rand].pregunta
            preguntasSelect = [preguntasPHPCollection[rand].respuestas[0],preguntasPHPCollection[rand].respuestas[1],preguntasPHPCollection[rand].respuestas[2],preguntasPHPCollection[rand].respuestas[3]]
            respuesta = preguntasPHPCollection[rand].rc
            preguntasPHPCollection.remove(at: rand)
            break
        case "BBDD":
            if preguntasBBDDCollection.count == 1{
                var position = 0
                for i in 0..<temas.count {
                    if temas[i] == "BBDD"{
                        position = i
                    }
                }
                temas.remove(at: position)
                forceRow();
            }
            let rand = Int(arc4random_uniform(UInt32(preguntasBBDDCollection.count)))
            labelPregunta.text = preguntasBBDDCollection[rand].pregunta
            preguntasSelect = [preguntasBBDDCollection[rand].respuestas[0],preguntasBBDDCollection[rand].respuestas[1],preguntasBBDDCollection[rand].respuestas[2],preguntasBBDDCollection[rand].respuestas[3]]
            respuesta = preguntasBBDDCollection[rand].rc
            preguntasBBDDCollection.remove(at: rand)
            break
        default:
            //En principio nunca se deberia ejecutar
            break
        }
    }
    
    //Habilitamods los botones ----------------------------------------------------------------------------------
    func onButtons(){
        for i in 0..<questions.count{
            questions[i].isEnabled = true
        }
    }
    
    //Deshabilitamos los botones --------------------------------------------------------------------------------
    func offButtons(){
        for i in 0..<questions.count{
            questions[i].isEnabled = false
        }
    }
    
    //Miramos si a acabado, si no forzamos el row --------------------------------------------------------------
    func forceRow(){
        if !temas.isEmpty{
            temaSeleccionado = temas[0]
        }
    }
    
    //Funcion que arranca el musicote
    func musicOn(){
        do{
            let audioPath = Bundle.main.path(forResource: "song", ofType: "mp3")//Ruta Cnacion
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)//Pasamos la cancion al player
        }catch{
            //Algo a pasado mu malo (Caso de no encontrar el fichero)
        }
        
        //Con esto hacemos que siga la musica con la app en segundo plano
        let session = AVAudioSession.sharedInstance()//
        
        do{
            try session.setCategory(AVAudioSessionCategoryPlayback)
        }catch{
            
        }
        player.play()
    }
    
    // Preguntas ----------------------------------------------------------------------------------------------------
    func iniciarPreguntas(){
        var java = Preguntas (pregunta: "¿Cual no es una variable?", rc: "Into", respuestas: ["String","Char","Double","Into"])
        preguntasJavaCollection.append(java)
        java = Preguntas (pregunta: "¿Que usariamos para pasar un objeto a String?", rc: "(String)", respuestas: ["(String)","toString",".String","[String]"])
        preguntasJavaCollection.append(java)
        java = Preguntas (pregunta: "¿Para acceder a variables privadas?", rc: "get", respuestas: ["get","take","set",".haveElement"])
        preguntasJavaCollection.append(java)
        java = Preguntas (pregunta: "¿Que podemos usar en un HashMap?", rc: ".size", respuestas: [".size",".takeKey",".lenght",".contains"])
        preguntasJavaCollection.append(java)
        
        var php = Preguntas (pregunta: "Inserción del código PHP en las páginas HTML", rc: "< ? y ? >", respuestas: ["<? y ?>","<php></php>","<html></html>","<* y *>"])
        preguntasPHPCollection.append(php)
        php = Preguntas (pregunta: "Enviar los datos a si mismo", rc: "Action", respuestas: ["Action","Description","File","Name"])
        preguntasPHPCollection.append(php)
        php = Preguntas (pregunta: "Pasar los parámetros entre páginas PHP", rc: "Post y Get", respuestas: ["Post y Get","Get y Put","Require e Include","Into e Include"])
        preguntasPHPCollection.append(php)
        php = Preguntas (pregunta: "Realizar una consulta a una base de datos MySQL", rc: "Query", respuestas: ["Query","Access","Db_access","Db_query"])
        preguntasPHPCollection.append(php)
        
        var bbdd = Preguntas (pregunta: "Sentencia SQL se emplea en la cláusula SET", rc: "Update", respuestas: ["Update","Drop","Select","Delete"])
        preguntasBBDDCollection.append(bbdd)
        bbdd = Preguntas (pregunta: "Eliminar contenido de una tabla pero conservandola", rc: "Truncate", respuestas: ["Truncate","Delete","Drop","Ninguna"])
        preguntasBBDDCollection.append(bbdd)
        bbdd = Preguntas (pregunta: "Ordenar datos devueltos por un Select", rc: "Order", respuestas: ["Order","Ordered","Sort","Sorted"])
        preguntasBBDDCollection.append(bbdd)
        bbdd = Preguntas (pregunta: "Eliminar las filas duplicadas", rc: "Distinct", respuestas: ["Distinct","No duplicate","Unique","Ninguna"])
        preguntasBBDDCollection.append(bbdd)
        
    }
    
}

