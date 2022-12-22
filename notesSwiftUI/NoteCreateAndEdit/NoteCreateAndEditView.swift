//
//  NoteCreateAndEditView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

struct NoteCreateAndEditView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel: NoteCreateAndEditViewModel
    
    @State var editTextContent: String
    @State var isNewNote: Bool
    
    var body: some View {
        TextEditor(text: isNewNote ? $viewModel.newTextContent : $viewModel.editTextContent)
        
            .onDisappear {
                if editTextContent.isEmpty {
                    viewModel.addNote(mainViewModel: mainViewModel)
                } else {
                    updateNote()
                }
                
            }
    }
    
    func addNote() {
        let newNote = Note(context: CoreDataManager.shared.viewContext)
        newNote.textContent = viewModel.newTextContent
        newNote.timestamp = Date()
        CoreDataManager.shared.save()
        mainViewModel.noteEntitys = CoreDataManager.shared.fetchData()
    }
    
    
    func updateNote() {
        viewModel.note?.textContent = viewModel.editTextContent
        CoreDataManager.shared.save()
        mainViewModel.noteEntitys = CoreDataManager.shared.fetchData()
    }
}
