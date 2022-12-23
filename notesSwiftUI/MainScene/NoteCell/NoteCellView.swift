//
//  NoteCellView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

struct NoteCellView: View {
    
    @StateObject var note: NoteEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(note.title ?? Date().toString)
                .font(.headline.bold())
            Text(note.textContent ?? "тут пока ни чего нет")
                .font(.callout)
            Spacer()
            HStack {
                Spacer()
                Text(note.timestamp?.toString ?? Date().toString)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .background(Color.white)
    }
}
