//
//  NoteCreateAndEditViewModel.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 22.12.2022.
//

import Foundation



class NoteCreateAndEditViewModel: ObservableObject {
        
    @Published var newTextContent: String = ""
    @Published var editTextContent: String
    @Published var note: Note?

    
    
    init(note: Note? = nil) {
        self.editTextContent = note?.textContent ?? "что то пощло не так, просто пустая заметка"
        self.note = note
    }


    func addNote(mainViewModel: MainViewModel) {
        let newNote = Note(context: CoreDataManager.shared.viewContext)
        newNote.textContent = newTextContent
        newNote.timestamp = Date()
        CoreDataManager.shared.save()
        mainViewModel.noteEntitys = CoreDataManager.shared.fetchData()
    }
//
//
//    func updateNote() {
//        note?.textContent = editTextContent
//        coreDataManager.save()
//        mainViewModel.noteEntitys = coreDataManager.fetchData()
//    }
    
}
