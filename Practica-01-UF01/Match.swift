//
//  Match.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

class Match {
    var idPartido:Int=0
    var fkLocalTeam:Int=0
    var fkAwayTeam:Int=0
    var localScore:Int=0
    var awayScore:Int=0
    
    init(fkLocalTeam:Int, fkAwayTeam:Int, localScore:Int, awayScore:Int) {
        self.fkLocalTeam = fkLocalTeam
        self.fkAwayTeam = fkAwayTeam
        self.localScore = localScore
        self.awayScore = awayScore
    }
    
    init(idPartido:Int, fkLocalTeam:Int, fkAwayTeam:Int, localScore:Int, awayScore:Int) {
        self.idPartido = idPartido
        self.fkLocalTeam = fkLocalTeam
        self.fkAwayTeam = fkAwayTeam
        self.localScore = localScore
        self.awayScore = awayScore
    }
}
