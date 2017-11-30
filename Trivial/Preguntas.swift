//
//  Preguntas.swift
//  Trivial
//
//  Created by Alex Lopez on 10/11/17.
//  Copyright © 2017 Alex Lopez. All rights reserved.
//

import UIKit

class Preguntas {
    var pregunta: String
    var respuestas: [String]
    var rc: String

    
    init(pregunta: String, rc: String, respuestas: [String]) {
        self.pregunta = pregunta
        self.rc = rc
        self.respuestas = respuestas
    }
    
    init() {
        pregunta = ""
        rc = ""
        respuestas = [String]()
    }
}
