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
                .foregroundColor(Color.palette.child.opacity(0.8))
            Text(note.textContent ?? "тут пока ни чего нет")
                .font(.callout)
                .foregroundColor(Color.palette.child.opacity(0.7))
            Spacer()
            HStack {
                Spacer()
                Text(note.timestamp?.toString ?? Date().toString)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.palette.child.opacity(0.2))
        .cornerRadius(15)
    }
}
