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
            if viewModel.isNewNote {
                Text("New Note")
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .font(.title.bold())
                    .padding(.leading, 24)
                    .foregroundColor(Color.palette.child.opacity(0.8))
            } else {
                Text("Edit Note")
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .font(.title.bold())
                    .padding(.leading, 24)
                    .foregroundColor(Color.palette.child.opacity(0.8))
            }
            
            TextField("название заметки", text: $viewModel.titleNote)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .font(.title2.bold())
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .background(Color.palette.child.opacity(0.13))
                .cornerRadius(10)
                .foregroundColor(Color.palette.child.opacity(0.8))
            
            Divider()
            
            TextEditor(text: viewModel.isNewNote ?
                       $viewModel.newTextContent : $viewModel.editTextContent)
            .tint(Color.palette.child.opacity(0.8))
            .foregroundColor(Color.palette.child.opacity(0.9))
            
            
            if viewModel.isNewNote {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 40))
                        .foregroundColor(Color.palette.child)
                }
            }
            
        }
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
                .foregroundColor(Color.palette.child.opacity(0.7))
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
