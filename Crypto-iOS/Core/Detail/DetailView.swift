//
//  DetailView.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 16/05/2023.
//

import SwiftUI

struct DetailedLoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("detail View for: \(coin.name)")
    }

    var body: some View {
        ZStack {
            if let coin = coin {
                Text(coin.name)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
