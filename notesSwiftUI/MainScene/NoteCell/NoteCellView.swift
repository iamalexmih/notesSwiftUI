//
//  NoteCellView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

struct NoteCellView: View {
    
    @StateObject var note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.headline.bold())
            Text(note.textContent ?? "тут пока ни чего нет")
                .font(.callout)
            HStack {
                Spacer()
                Text(note.timestamp?.formatted(date: .numeric, time: .standard) ?? Date().formatted(date: .numeric, time: .standard))
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

//struct NoteCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteCellView()
//    }
//}
