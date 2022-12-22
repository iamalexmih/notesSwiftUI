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
    var note: Note?
    
    var body: some View {
        TextEditor(text: $editTextContent)
        
            .onDisappear {
                updateNote()
            }
    }
    
    
    func updateNote() {
        note?.textContent = editTextContent
        //        print("note?.textContent \(note.textContent)")
        CoreDataManager.shared.save()
        mainViewModel.noteEntitys = CoreDataManager.shared.fetchData()
        print(mainViewModel.noteEntitys)
    }
}
