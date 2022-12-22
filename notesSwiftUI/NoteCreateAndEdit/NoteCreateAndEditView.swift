//
//  NoteCreateAndEditView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

struct NoteCreateAndEditView: View {
    
    //@EnvironmentObject var coreDataManager: CoreDataManager
    @StateObject var viewModel: NoteCreateAndEditViewModel
    
    var body: some View {
        TextEditor(text: viewModel.isNewNote ? $viewModel.newTextContent : $viewModel.editTextContent)
        
            .onDisappear {
                if viewModel.editTextContent.isEmpty {
                    print("onDisappear addNote")
                    viewModel.addNote()
                } else {
                    print("onDisappear updateNote")
                    //print(viewModel.editTextContent)
                    viewModel.updateNote()
                }
            }
    }
}
