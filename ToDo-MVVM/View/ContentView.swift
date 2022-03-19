//
//  ContentView.swift
//  ToDo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - VIEW MODELS
    
    @ObservedObject var todoListViewModel: TodoListUserDefaultsViewModel
    
    // MARK: - STATE / BINDING
    
    @State var input: String = ""
    
    // MARK: - INIT
    
    init() {
        self.todoListViewModel = TodoListUserDefaultsViewModel()
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        NavigationView {
            Form {
                
                // MARK: - ADD SECTION
                
                Section {
                    HStack {
                        TextField("Ajouter un Todo", text: self.$input)
                        
                        Button(action: {
                            self.todoListViewModel.add(item: self.input)
                            self.input = ""
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                    }
                }
                
                // MARK: - LIST SECTION
                
                Section(header: Text("Ma liste")) {
                    List {
                        ForEach (self.todoListViewModel.list) { todo in
                            HStack {
                                Text(todo.title)
                                
                                Spacer(minLength: 20)
                                
                                Button(action: {
                                    self.todoListViewModel.update(todo: todo)
                                }, label: {
                                    self.todoStateLogo(done: todo.done)
                                })
                            }
                        }
                        .onDelete(perform: { index in
                            self.todoListViewModel.detete(index: index)
                        })
                    }
                }
                
            }
            .navigationTitle(Text("Todo List MVVM"))
        }
    }
    
    // MARK: - FUNCTIONS
    
    func todoStateLogo(done: Bool) -> some View {
        let logo: String = done ? "checkmark.square" : "x.square"
        let color: Color = done ? .green : .red
        return Image(systemName: logo).foregroundColor(color)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
