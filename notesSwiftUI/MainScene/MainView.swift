//
//  ContentView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI
import CoreData

struct MainView: View {
    
//    @EnvironmentObject var coreDataManager: CoreDataManager
    @EnvironmentObject var mainViewModel: MainViewModel
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(mainViewModel.noteEntitys) { note in
                        NoteCellView(note: note)
                            .onTapGesture {
                                mainViewModel.selectedNote = note
                                mainViewModel.isEditNote.toggle()
                                mainViewModel.editTextContent = note.textContent ?? "пустая заметка"
                                print("onTapGesture")
                            }
                            .sheet(item: $mainViewModel.selectedNote)  {
//                                print("isEditNote")
                            } content: { selectedNote in
                                NoteCreateAndEditView(
                                    viewModel: NoteCreateAndEditViewModel(
                                        newTextContent: "",
                                        isNewNote: mainViewModel.isNewNote,
                                        editTextContent: mainViewModel.editTextContent,
                                        note: selectedNote,
                                        mainViewModel: mainViewModel
                                    ))
                            }
                    }
                    .onDelete(perform: mainViewModel.deleteNote)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                BottomPanelView(action: addNote)
            }
            .navigationTitle("Notes")
            .sheet(isPresented: $mainViewModel.isNewNote) {
//                mainViewModel.coreDataManager.save()
//                mainViewModel.updateData()
            } content: {
                NoteCreateAndEditView(
                    viewModel: NoteCreateAndEditViewModel(
                        newTextContent: mainViewModel.newTextContent,
                        isNewNote: mainViewModel.isNewNote,
                        editTextContent: "",
                        mainViewModel: mainViewModel
                    ))
            }
           

        }
    }
    
    private func addNote() {
        mainViewModel.newTextContent = ""
        mainViewModel.isNewNote = true
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
