//
//  MainViewModel.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 22.12.2022.
//

import Foundation


class MainViewModel: ObservableObject {
    
    var coreDataManager = CoreDataManager.shared
    
    @Published var noteEntitys: [NoteEntity] = []

    @Published var isNewNote: Bool = false    
    
    
    init() {
        updateData()
    }
    
    func addNote() {
        isNewNote.toggle()
    }
    
    
    func updateData() {
        noteEntitys = coreDataManager.fetchData()
    }
    
    
    func deleteNote(note: NoteEntity) {
        coreDataManager.viewContext.delete(note)
        coreDataManager.save()
        updateData()
    }
    
    
//    func deleteNote(indexSet: IndexSet) {
//        guard let index = indexSet.first else { return }
//        let entity = noteEntitys[index]
//        coreDataManager.viewContext.delete(entity)
//        coreDataManager.save()
//        updateData()
//    }
    
}
