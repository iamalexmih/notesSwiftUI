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
    
    let colums: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    Text("List Notes")
                        .font(.title.bold())
                        .foregroundColor(Color.palette.child)
                    ScrollView {
                        LazyVGrid(columns: colums, spacing: 30) {
                            ForEach(mainViewModel.noteEntitys) { note in
                                NavigationLink {
                                    NoteCreateAndEditView(
                                        viewModel: NoteCreateAndEditViewModel(note: note,
                                                                              isNewNote: mainViewModel.isNewNote),
                                        editTextContent: note.textContent ?? "")
                                    
                                } label: {
                                    NoteCellView(note: note)
                                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 110)
                                        .swipeDeleteCustomModifier {
                                            mainViewModel.deleteNote(note: note)
                                        }
                                }
                                
                                
                            }
                            .listRowBackground(Color.palette.child)
                        }
                        
                        .padding(.top, 50)
                    }
                    .padding(.horizontal)
                    
                }
                
                
                Button (action: mainViewModel.addNote) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.palette.child)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
                .padding(.trailing, 20)
                
            }
            
            .sheet(isPresented: $mainViewModel.isNewNote) {
                NoteCreateAndEditView(viewModel: NoteCreateAndEditViewModel(
                    isNewNote: mainViewModel.isNewNote),
                                      editTextContent: "")
                
            }
            .background(Color.palette.parent.edgesIgnoringSafeArea(.all))
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel())
    }
}
