//
//  NoteCreateAndEditView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

struct NoteCreateAndEditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel: NoteCreateAndEditViewModel
    
    @State var editTextContent: String
    
    var body: some View {
        VStack {
            TextField("название заметки", text: $viewModel.titleNote)
                .font(.title.bold())
            Divider()
            
            TextEditor(text: viewModel.isNewNote ? $viewModel.newTextContent : $viewModel.editTextContent)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.left")
                                if viewModel.changeButtonBackText()
                                {
                                    Text("Back")
                                } else {
                                    Text("Save and Back")
                                }
                                
                            }
                        }

                    }
                }
            
                .navigationBarBackButtonHidden(true)
                .onDisappear {
                    if editTextContent.isEmpty {
                        viewModel.addNote(mainViewModel: mainViewModel)
                    } else {
                        viewModel.updateNote(mainViewModel: mainViewModel)
                    }
                    
            }
        }
        .navigationTitle("Edit Note")
        .padding()
    }
}


struct NoteCreateAndEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreateAndEditView(viewModel: NoteCreateAndEditViewModel(isNewNote: true),
                              editTextContent: "")
            .environmentObject(MainViewModel())
    }
}
