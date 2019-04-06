//
//  SQLFactory.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

class SQLFactory {
    class func createFactory(_ type:Int)->SQLiteDAO?{
        switch(type){
            case 0: return MatchManager()
            case 1: return TeamManager()
        default:
            break
            
        }						
        return nil
    }
}
