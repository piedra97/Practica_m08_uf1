//
//  Match.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

class Match {
    var idPartido:Int
    var fkLocalTeam:Int
    var fkAwayTeam:Int
    var localScore:Int
    var awayScore:Int
    
    init(idPartido:Int, fkLocalTeam:Int, fkAwayTeam:Int, localScore:Int, awayScore:Int) {
        self.idPartido = idPartido
        self.fkLocalTeam = idPartido
        self.fkAwayTeam = idPartido
        self.localScore = idPartido
        self.awayScore = idPartido
    }
}
