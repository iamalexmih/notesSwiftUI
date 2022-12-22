//
//  Persistence.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import CoreData

class CoreDataManager: ObservableObject {
   
//    @Published var noteEntitys: [Note] = []
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: "NotesContainer")
        loadPersistentStores()
    }
    
    
    func loadPersistentStores() {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                print("ERROR loading Core Data: \(error!.localizedDescription)")
                return
            }
            print("Ok, load Persistent Stores")
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                print("save")
            } catch {
                print("An ERROR occurred while save: \(error.localizedDescription)")
            }
        }
    }
    
    
    func fetchData() -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        var noteEntitys: [Note] = []
        do {
            noteEntitys = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchTask: \(error.localizedDescription)")
        }
        return noteEntitys
    }
    

    func deleteAllData() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let allNoteEntitys = try viewContext.fetch(request)
            for note in allNoteEntitys {
                viewContext.delete(note)
            }
        } catch let error {
            print("Error load fetchTask: \(error.localizedDescription)")
        }
        save()
    }
}
