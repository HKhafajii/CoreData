//
//  ContentView.swift
//  CoreDataBootcamp
//
//  Created by Hassan Alkhafaji on 11/25/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Friend.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Friend.name, ascending: true)]
    )
    var friends: FetchedResults<Friend>

    var body: some View {
        NavigationView {
            List {
                ForEach(friends) { friend in
                    Text(friend.name ?? "")
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("FriendsList")
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: addItem) {
                        Text("Add an Item")
                        Image(systemName: "plus")
                    }
                    
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            
            let newFriend = Friend(context: viewContext)
            newFriend.name = "Kelvin"
            viewContext.insert(newFriend)
           saveItems()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            
            guard let index = offsets.first else {return}
            let friendEntity = friends[index]
            viewContext.delete(friendEntity)
//            offsets.map { items[$0] }.forEach(viewContext.delete)
            saveItems()
           
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
