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
    
    @StateObject var vm : DetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("detail View for: \(coin.name)")
    }

    var body: some View {
        ZStack {
            Text("Crypto")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
