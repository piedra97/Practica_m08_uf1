//
//  SQLiteSingleton.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

private let dataBaseFileName:String = "nba.db"
private var dataBasePath:String=String()

private var database:FMDatabase?

class SQLiteSingleton{
    
    class func getInstance()->FMDatabase{
        
        if (database==nil){
            
            let fileManager=FileManager()
            
            if let docsDir=fileManager.urls(for: .documentDirectory, in: .userDomainMask).first{
                let databaseURL = docsDir.appendingPathComponent(dataBaseFileName)
                dataBasePath = databaseURL.absoluteString
                database = FMDatabase(path: dataBasePath)
            }
        }
        return database!
    }

}
