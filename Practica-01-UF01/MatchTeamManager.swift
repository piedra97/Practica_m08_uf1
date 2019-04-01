//
//  MatchTeamManager.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

class MatchTeamManager: SQLiteDAO {
    var result = false
    func insert(_ database: FMDatabase, newRecord: AnyObject) -> Bool {
        if database.open() {
            let insertSQL = "INSERT INTO MATCH_TEAM (IDFK_MATCH, IDFK_TEAM,SCORE) VALUES(?,?,?)"
            let data:Array=["\((newRecord as! MatchTeam).idPartido)", "\((newRecord as! MatchTeam).idEquipo)","\((newRecord as! MatchTeam).puntuacion)"]
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
            let deleteSQL = "DELETE FROM MATCH_TEAM WHERE IDFK_MATCH = ?"
            let data:Array=["\(recordToDelete)"]
            result = database.executeUpdate(deleteSQL, withArgumentsIn: data)
            database.close()
        }else {
            print("Error: \(database.lastErrorMessage())")
            
        }
        return result
        
    }
    
    
    func readRecords(_ database: FMDatabase) -> Array<AnyObject> {
        var arrayResult:Array<MatchTeam>=Array()
        if database.open() {
            let querySQL = "SELECT * FROM MATCH_TEAM"
            if let results:FMResultSet = database.executeQuery(querySQL, withArgumentsIn: arrayResult) {
                
                while(results.next()){
                    let matchTeam = MatchTeam(idEquipo: Int(results.int(forColumnIndex: 0)),idPartido: Int(results.int(forColumnIndex: 0)), puntuacion: Int(results.int(forColumnIndex: 0)))
                    arrayResult.append(matchTeam)
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
