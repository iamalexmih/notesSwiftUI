//
//  ContentView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(mainViewModel.noteEntitys) { note in
                        NavigationLink {
                            NoteCreateAndEditView(
                                viewModel: NoteCreateAndEditViewModel(note: note,
                                                                      isNewNote: mainViewModel.isNewNote),
                                editTextContent: note.textContent ?? "")
                        } label: {
                            NoteCellView(note: note)
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 60)
                                .padding(.vertical, 5)
                        }
                        
                    }
                    .onDelete(perform: mainViewModel.deleteNote)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                
                Button (action: mainViewModel.addNote) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
                .padding(.trailing, 20)
                
                //BottomPanelView(action: addNote)
            }
            .navigationTitle("List Notes")
            .sheet(isPresented: $mainViewModel.isNewNote) {
                NoteCreateAndEditView(viewModel: NoteCreateAndEditViewModel(
                        isNewNote: mainViewModel.isNewNote),
                    editTextContent: "")

            }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel())
    }
}
