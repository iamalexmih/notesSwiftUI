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
    
    var body: some View {
        TextEditor(text: viewModel.isNewNote ? $viewModel.newTextContent : $viewModel.editTextContent)
        
            .onDisappear {
                if editTextContent.isEmpty {
                    viewModel.addNote(mainViewModel: mainViewModel)
                } else {
                    viewModel.updateNote(mainViewModel: mainViewModel)
                }
                
            }
    }
}
