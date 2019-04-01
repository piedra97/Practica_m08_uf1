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
            let insertSQL = "INSERT INTO MATCH (ID_MATCH) VALUES(?)"
            let data:Array=["\((newRecord as! Match).idPartido)"]
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
                let deleteSQL = "DELETE FROM MATCH WHERE ID_MATCH = ?"
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
            let querySQL = "SELECT * FROM MATCH"
            if let results:FMResultSet = database.executeQuery(querySQL, withArgumentsIn: arrayResult) {
                
                while(results.next()){
                    let match = Match(idPartido: Int(results.int(forColumnIndex: 0)))
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
    
}
    
    

