//
//  MainViewModel.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 22.12.2022.
//

import Foundation


class MainViewModel: ObservableObject {
    
    var coreDataManager = CoreDataManager.shared
    
    @Published var noteEntitys: [Note] = []
    
    @Published var newTextContent: String = ""
    @Published var editTextContent: String = ""
    @Published var isNewNote: Bool = false
    @Published var isNewNoteString: String = ""
    @Published var isEditNote: Bool = false
    @Published var selectedNote: Note? = nil
    
    
    
    init() {
//        coreDataManager.deleteAllData()
        updateData()
    }
    
    func updateData() {
        noteEntitys = coreDataManager.fetchData()
    }
    
    func deleteNote(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = noteEntitys[index]
        coreDataManager.viewContext.delete(entity)
        coreDataManager.save()
        updateData()
    }
    
}
