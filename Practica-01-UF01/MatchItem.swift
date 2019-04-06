//
//  MatchItem.swift
//  Practica-01-UF01
//
//  Created by Mac de Pol on 06/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import Foundation

class MatchItem {
    var items:[Match] = [Match]()
    
    func addItem(item: Match) {
        self.items.append(item)
    }
    
    func deleteItem(index : Int) {
        self.items.remove(at: index)
    }
}
