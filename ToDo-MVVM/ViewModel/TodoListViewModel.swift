//
//  TodoListViewModel.swift
//  ToDo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import SwiftUI

class TodoListViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    var sample: [String] = ["Menage", "Courses", "Cuisine", "Laver la voiture"]
    
    // MARK: - DATA BINDING
    
    @Published var list: [Todo] = []
    
    // MARK: - INIT
    
    init() {
        self.list = self.sample.map({ item in
            Todo(title: item, done: false)
        })
    }
    
    // MARK: - ACTIONS
    
    func update(todo: Todo) {
        guard let index = self.list.firstIndex(where: { $0.id == todo.id }) else { return }
        self.list[index].done.toggle()
    }
    
    func add(item: String) {
        guard item != "" else { return }
        self.list.append(Todo(title: item, done: false))
    }
    
    func detete(index: IndexSet) {
        self.list.remove(atOffsets: index)
    }
}
