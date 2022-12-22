//
//  notesSwiftUIApp.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

@main
struct notesSwiftUIApp: App {
//    @StateObject var coreDataManager = CoreDataManager()
    @StateObject var viewModel = MainViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
