//
//  Team.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

class Team {
    var idTeam:String
    var teamName:String
    var conference:String
    var city:String
    var logo:String
    
    init (idTeam:String, teamName:String, conference:String, city:String, logo:String) {
        self.idTeam = idTeam
        self.teamName = teamName
        self.conference = conference
        self.city = city
        self.logo = logo
    }
}
