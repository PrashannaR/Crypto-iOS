//
//  xmarkButton.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 05/05/2023.
//

import SwiftUI

struct xmarkButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }

    }
}

struct xmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        xmarkButton()
    }
}

