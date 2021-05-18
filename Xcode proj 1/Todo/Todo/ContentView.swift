//
//  ContentView.swift
//  Todo
//
//  Created by Drole on 10/05/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(fetchRequest: ToDoItems.getAllToDoItems())
    var items: FetchedResults<ToDoItems>
    
    @State var text:String = ""
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("New Item")) {
                    HStack{
                        TextField("Enter new Todo..", text:$text)
                        Button(action: {
                            
                            if !text.isEmpty{
                                
                                let newItem = ToDoItems(context: context)
                                newItem.name = text
                                newItem.createdAt = Date()
                                
                                do{
                                    try context.save()
                                }
                                catch{
                                }
                                text = ""
                            }
                        }, label:{
                            Text("Save")
                        })
                    }
                }
                Section {
                    ForEach(items) {
                        ToDOListitems in
                        VStack(alignment:.leading){
                            Text(ToDOListitems.name!).font(.headline)
                            Text("\(ToDOListitems.createdAt!)").font(.footnote)
                            
                        }
                    }.onDelete(perform: {indexSet in
                        guard let index = indexSet.first else {
                            return
                        }
                        let itemToDelete = items[index]
                        context.delete(itemToDelete)
                        do {
                          try  context.save()
                        }
                        catch{
                            print(error)
                        }
                    })
                }
                
                }
            .navigationTitle("ToDo List")
            
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
           
    }
}
