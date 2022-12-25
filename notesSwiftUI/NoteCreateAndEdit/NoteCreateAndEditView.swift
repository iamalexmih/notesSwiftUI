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
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        VStack {
            textTitleScene(viewModel.isNewNote)
            titleNoteTextField(text: $viewModel.titleNote, focusedField: $focusedField)
            
            TextEditor(text: viewModel.isNewNote ?
                       $viewModel.newTextContent : $viewModel.editTextContent)
                .focused($focusedField, equals: .textEditor)
                .tint(.palette.child.opacity(0.8))
                .foregroundColor(.palette.child.opacity(0.9))
            
            if viewModel.isNewNote {
                buttonCloseNewNote
                    .foregroundColor(.palette.child)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                buttonBack
                    .foregroundColor(.palette.child.opacity(0.7))
            }
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = nil
            } label: {
                Text("hide keyboard")
                    .foregroundColor(.palette.child.opacity(0.5))
                }
                    
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            if editTextContent.isEmpty {
                viewModel.addNote(mainViewModel: mainViewModel)
            } else {
                viewModel.updateNote(mainViewModel: mainViewModel)
            }
        }
    }
}

// MARK: - Helpers

extension NoteCreateAndEditView {
    private var buttonBack: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "arrow.left")
                if viewModel.changeButtonBackText() {
                    Text("Back")
                } else {
                    Text("Save and Back")
                }
            }
        }
    }
    
    
    private var buttonCloseNewNote: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.down.circle")
                .font(.system(size: 40))
        }
    }
    
    
    @ViewBuilder private func textTitleScene(_ isNewNote: Bool)  -> some View {
        let textNewNote = "Create New Note"
        let textEditNote = "Edit Note"
        
        Text(isNewNote ? textNewNote : textEditNote)
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .font(.title.bold())
            .padding(.leading, 24)
            .foregroundColor(.palette.child.opacity(0.8))
    }
    
    
    private func titleNoteTextField(text: Binding<String>,
                                    focusedField: FocusState<FocusField?>.Binding)  -> some View  {
        TextField("название заметки", text: text)
            .focused(focusedField, equals: .titleTextField)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .font(.title2.bold())
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(Color.palette.child.opacity(0.13))
            .cornerRadius(10)
            .foregroundColor(.palette.child.opacity(0.8))
    }
}




struct NoteCreateAndEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreateAndEditView(viewModel: NoteCreateAndEditViewModel(isNewNote: true),
                              editTextContent: "")
        .environmentObject(MainViewModel())
    }
}
