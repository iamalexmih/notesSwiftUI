//
//  NoteCreateAndEditView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

struct NoteCreateAndEditView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @State var editTextContent: String
    @State var newTextContent: String
    @State var isNewNote: Bool
    var note: Note?
    
    var body: some View {
        TextEditor(text: isNewNote ? $newTextContent : $editTextContent)
        
            .onDisappear {
                if editTextContent.isEmpty {
                    addNote()
                } else {
                    updateNote()
                }
                
            }
    }
    
    func addNote() {
        let newNote = Note(context: CoreDataManager.shared.viewContext)
        newNote.textContent = newTextContent
        newNote.timestamp = Date()
        CoreDataManager.shared.save()
        mainViewModel.noteEntitys = CoreDataManager.shared.fetchData()
    }
    
    
    func updateNote() {
        note?.textContent = editTextContent
        CoreDataManager.shared.save()
        mainViewModel.noteEntitys = CoreDataManager.shared.fetchData()
    }
}
