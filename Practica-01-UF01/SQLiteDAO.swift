//
//  SQLiteDAO.swift
//  Practica-01-UF01
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

protocol SQLiteDAO {
    func insert(_ database:FMDatabase, newRecord: AnyObject)->Bool
    func delete(_ database:FMDatabase, recordToDelete: AnyObject)->Bool
    func readRecords(_ database:FMDatabase)->Array<AnyObject>
}
