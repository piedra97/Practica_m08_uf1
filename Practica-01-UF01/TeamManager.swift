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
    
        return false
        
    }
    
    func delete(_ database: FMDatabase, recordToDelete: AnyObject) -> Bool {
    
        return false
        
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
    
    func selecTeamNameInMatch(_ database: FMDatabase,_ recordToSelect: AnyObject) -> String {
        var result = [String]()
        if database.open() {
            let querySQL = "SELECT NOMBRE FROM EQUIPO WHERE ID_EQUIPO = ?"
            let data:Array=["\(recordToSelect)"]
            if let results:FMResultSet = database.executeQuery(querySQL, withArgumentsIn: data) {
                while(results.next()) {
                    let name = String(results.string(forColumn: "NOMBRE")!)
                    result.append(name)
                }
                results.close()
            }
            database.close()
            
        }else {
            print("Error: \(database.lastErrorMessage())")
        }
        
        return result[0]
    }
    
    func selecTeamIDWhitName(_ database: FMDatabase,_ recordToSelect: AnyObject) -> Int {
        var result = [Int]()
        if database.open() {
            let querySQL = "SELECT ID_EQUIPO FROM EQUIPO WHERE NOMBRE = ?"
            let data:Array=["\(recordToSelect)"]
            if let results:FMResultSet = database.executeQuery(querySQL, withArgumentsIn: data) {
                while(results.next()) {
                    let id = Int(results.string(forColumn: "ID_EQUIPO")!)
                    result.append(id ?? 0)
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
