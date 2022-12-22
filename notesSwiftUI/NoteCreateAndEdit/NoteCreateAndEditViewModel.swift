//
//  NoteCreateAndEditViewModel.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 22.12.2022.
//

import Foundation



class NoteCreateAndEditViewModel: ObservableObject {
    
    var coreDataManager = CoreDataManager.shared
    
    @Published var newTextContent: String
    @Published var isNewNote: Bool
    @Published var editTextContent: String
    @Published var note: Note?
    @Published var mainViewModel: MainViewModel
    
    
    init(newTextContent: String,
         isNewNote: Bool,
         editTextContent: String,
         note: Note? = nil,
         mainViewModel: MainViewModel) {
        self.newTextContent = newTextContent
        self.isNewNote = isNewNote
        self.editTextContent = editTextContent
        self.note = note
        self.mainViewModel = mainViewModel
    }


    func addNote() {
        let newNote = Note(context: coreDataManager.viewContext)
        newNote.textContent = newTextContent
        newNote.timestamp = Date()
        coreDataManager.save()
        mainViewModel.noteEntitys = coreDataManager.fetchData()
    }
    
    
    func updateNote() {
        note?.textContent = editTextContent
        print("note?.textContent \(note?.textContent)")
        coreDataManager.save()
        mainViewModel.noteEntitys = coreDataManager.fetchData()
    }
    
}
