//
//  TeamManager.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

class TeamManager: SQLiteDAO {
    var result = false
    func insert(_ database: FMDatabase, newRecord: AnyObject) -> Bool {
        if database.open() {
            let insertSQL = "INSERT INTO EQUIPO (ID_EQUIPO, NOMBRE, CONFERENCIA, CIUDAD, LOGO ) VALUES(?,?,?,?,?)"
            let data:Array=["\((newRecord as! Team).idTeam)", "\((newRecord as! Team).teamName)","\((newRecord as! Team).conference)","\((newRecord as! Team).city)", "\((newRecord as! Team).logo)"]
            result = database.executeUpdate(insertSQL, withArgumentsIn: data)
            database.close()
        }else {
            print("Error: \(database.lastErrorMessage())")
            
        }
        return result
        
    }
    
    func delete(_ database: FMDatabase, recordToDelete: AnyObject) -> Bool {
        var result = false
        if database.open() {
            let deleteSQL = "DELETE FROM EQUIPO WHERE ID_EQUIPO = ?"
            let data:Array=["\(recordToDelete)"]
            result = database.executeUpdate(deleteSQL, withArgumentsIn: data)
            database.close()
        }else {
            print("Error: \(database.lastErrorMessage())")
            
        }
        return result
        
    }
    
    
    func readRecords(_ database: FMDatabase) -> Array<AnyObject> {
        var arrayResult:Array<Team>=Array()
        if database.open() {
            let querySQL = "SELECT * FROM EQUIPO"
            if let results:FMResultSet = database.executeQuery(querySQL, withArgumentsIn: arrayResult) {
                
                while(results.next()){
                    let team = Team(idTeam: Int(results.int(forColumnIndex: 0)),teamName: String(results.string(forColumnIndex: 1)!), conference: String(results.string(forColumnIndex: 2)!), city: String(results.string(forColumnIndex: 3)!), logo: String(results.string(forColumnIndex: 4)!))
                    arrayResult.append(team)
                }
                results.close()
            }
            database.close()
        } else {
            print("Error: \(database.lastErrorMessage())")
            
        }
        return arrayResult
    }
    
}
