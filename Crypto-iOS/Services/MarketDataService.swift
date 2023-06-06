//
//  MarketDataService.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 05/05/2023.
//

import Combine
import Foundation

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil

    var marketDataSubscription: AnyCancellable?

    init() {
        getData()
    }

    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }

        marketDataSubscription =
            NetworkingManager.download(url: url)
                .decode(type: GlobalData.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: NetworkingManager.handleCompletion,
                      receiveValue: { [weak self] returnedGlobalData in
                          self?.marketData = returnedGlobalData.data
                          self?.marketDataSubscription?.cancel()
        })
    }
}
