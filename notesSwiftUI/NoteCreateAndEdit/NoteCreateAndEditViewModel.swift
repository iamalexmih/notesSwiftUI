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
    @Published var isNewNote: Bool

    var coreDataManager = CoreDataManager.shared
    
    
    init(note: Note? = nil, isNewNote: Bool) {
        self.editTextContent = note?.textContent ?? "что то пошло не так, просто пустая заметка"
        self.note = note
        self.isNewNote = isNewNote
    }


    func addNote(mainViewModel: MainViewModel) {
        let newNote = Note(context: coreDataManager.viewContext)
        newNote.textContent = newTextContent
        newNote.timestamp = Date()
        coreDataManager.save()
        mainViewModel.noteEntitys = coreDataManager.fetchData()
    }


    func updateNote(mainViewModel: MainViewModel) {
        note?.textContent = editTextContent
        note?.timestamp = Date()
        coreDataManager.save()
        mainViewModel.noteEntitys = coreDataManager.fetchData()
    }
}
