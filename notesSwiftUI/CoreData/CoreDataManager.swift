//
//  Persistence.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import CoreData

class CoreDataManager: ObservableObject {
       
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
        }
    }
    
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An ERROR occurred while save: \(error.localizedDescription)")
            }
        }
    }
    
    
    func fetchData() -> [NoteEntity] {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        var noteEntitys: [NoteEntity] = []
        do {
            noteEntitys = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchTask: \(error.localizedDescription)")
        }
        return noteEntitys
    }
    

    func deleteAllData() {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
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
