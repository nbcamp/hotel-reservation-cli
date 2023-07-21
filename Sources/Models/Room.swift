//
//  File.swift
//
//
//  Created by Jinyong Park on 2023/07/21.
//

import Foundation

class Room {
    static var nextId: ID = 1
    
    var id: ID
    var name: String
    var price: Int

    init(name: String, price: Int) {
        self.id = Room.nextId
        self.name = name
        self.price = price
        
        Room.nextId += 1
    }
}
