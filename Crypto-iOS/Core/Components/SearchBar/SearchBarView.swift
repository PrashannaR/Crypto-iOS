//
//  SearchBarView.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 02/05/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchtText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchtText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            TextField("Search by name or symbol...", text: $searchtText)
                .autocorrectionDisabled(true)
                .foregroundColor(Color.theme.accent)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(searchtText.isEmpty ? 0.0 : 1.0)
                        .foregroundColor(Color.theme.accent)
                        .padding()
                        .offset(x:10)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchtText = ""
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15),
                        radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchtText: .constant(""))
                .preferredColorScheme(.light)
            SearchBarView(searchtText: .constant(""))
                .preferredColorScheme(.dark)
        }
    }
}
