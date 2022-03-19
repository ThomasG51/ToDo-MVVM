//
//  Todo.swift
//  ToDo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import Foundation

struct Todo: Codable, Identifiable {
    
    var id: UUID = UUID()
    var title: String
    var done: Bool
    
}
