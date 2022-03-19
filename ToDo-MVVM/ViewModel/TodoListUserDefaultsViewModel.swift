//
//  TodoListUserDefaultsViewModel.swift
//  ToDo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import SwiftUI

class TodoListUserDefaultsViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    let ud: UserDefaults = UserDefaults.standard
    let key: String = "UD-KEY"
    
    // MARK: - DATA BINDING
    
    @Published var list: [Todo] = []
    
    // MARK: - INIT
    
    init() {
        guard let data: Data = ud.data(forKey: self.key) else { return }
        
        do {
            self.list = try JSONDecoder().decode([Todo].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - ACTIONS
    
    private func sync() {
        do {
            let encoded: Data = try JSONEncoder().encode(self.list)
            self.ud.set(encoded, forKey: self.key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(todo: Todo) {
        guard let index = self.list.firstIndex(where: { $0.id == todo.id }) else { return }
        self.list[index].done.toggle()
        self.sync()
    }
    
    func add(item: String) {
        guard item != "" else { return }
        self.list.append(Todo(title: item, done: false))
        self.sync()
    }
    
    func detete(index: IndexSet) {
        self.list.remove(atOffsets: index)
        self.sync()
    }
    
}
