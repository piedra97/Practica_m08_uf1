//
//  MatchManager.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

class MatchManager: SQLiteDAO {
    var result = false
    func insert(_ database: FMDatabase, newRecord: AnyObject) -> Bool {
        if database.open() {
            let insertSQL = "INSERT INTO PARTIDO (FK_EQUIPO_LOCAL, FK_EQUIPO_VISITANTE, PUNTUACION_LOCAL, PUNTUACION_VISITANTE) VALUES(?, ?, ?, ?)"
            let data:Array=["\((newRecord as! Match).fkLocalTeam)", "\((newRecord as! Match).fkAwayTeam)", "\((newRecord as! Match).localScore)", "\((newRecord as! Match).awayScore)"]
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
                let deleteSQL = "DELETE FROM PARTIDO WHERE PARTIDO_ID = ?"
                let data:Array=["\(recordToDelete)"]
                result = database.executeUpdate(deleteSQL, withArgumentsIn: data)
                database.close()
            }else {
                print("Error: \(database.lastErrorMessage())")
                
        }
            return result
        
    }
    
    
    func readRecords(_ database: FMDatabase) -> Array<AnyObject> {
        var arrayResult:Array<Match>=Array()
        if database.open() {
            let querySQL = "SELECT * FROM PARTIDO"
            if let results:FMResultSet = database.executeQuery(querySQL, withArgumentsIn: arrayResult) {
                
                while(results.next()){
                    let match = Match(idPartido: Int(results.int(forColumnIndex: 0)), fkLocalTeam:  Int(results.int(forColumnIndex: 1)), fkAwayTeam:  Int(results.int(forColumnIndex: 2)), localScore:  Int(results.int(forColumnIndex: 3)), awayScore:  Int(results.int(forColumnIndex: 4)))
                    arrayResult.append(match)
                }
                results.close()
            }
            database.close()
        } else {
            print("Error: \(database.lastErrorMessage())")
            
        }
        return arrayResult
        
    }
    
    func selecPKMatch(_ database: FMDatabase) -> Int {
        var result = [Int]()
        if database.open() {
            let querySQL = "SELECT MAX(PARTIDO_ID) FROM PARTIDO"
            if let results:FMResultSet = database.executeQuery(querySQL, withArgumentsIn: result) {
                while(results.next()) {
                    let id = results.int(forColumnIndex: 0)
                    result.append(Int(id))
                }
                results.close()
            }
            database.close()
            
        }else {
            print("Error: \(database.lastErrorMessage())")
        }
        
        return result[0]
    }

    
        
}
    
    

