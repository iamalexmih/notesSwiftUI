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
            ZStack {
                List {
                    ForEach(mainViewModel.noteEntitys) { note in
                        NavigationLink {
                            NoteCreateAndEditView(editTextContent: note.textContent ?? "пустая",
                                                  note: note)
                        } label: {
                            NoteCellView(note: note)
                        }
                        
                        
                        
                    }
                    .onDelete(perform: mainViewModel.deleteNote)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                
                Button (action: addNote) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
                .padding(.trailing, 20)

                //BottomPanelView(action: addNote)
            }
            .navigationTitle("Notes")
            .sheet(isPresented: $mainViewModel.isNewNote) {
                //                NoteCreateAndEditView(
                //                    viewModel: NoteCreateAndEditViewModel(
                //                        newTextContent: mainViewModel.newTextContent,
                //                        isNewNote: mainViewModel.isNewNote,
                //                        editTextContent: "",
                //                        mainViewModel: mainViewModel
                //                    ))
            }
            
            
        }
    }
    
    private func addNote() {
        mainViewModel.newTextContent = ""
        mainViewModel.isNewNote = true
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel())
    }
}
