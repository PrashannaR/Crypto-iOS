//
//  HomeViewModel.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 29/04/2023.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    @Published var searchBarText: String = ""

    private let coinDataService = CoinDataService()

    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    private let portfolioDataService = PortfolioDataService()

    @Published var statistics: [StatisticModel] = []

    init() {
        addSubscriber()
    }

    func addSubscriber() {
        // updates allCoins
        $searchBarText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .map(filteredCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)

        
        //this updates the market data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink {[weak self] recivedState in
                self?.statistics = recivedState
            }
            .store(in: &cancellables)
        
        //updates portfolio coins
        
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel]{
        var stats: [StatisticModel] = []

        guard let data = marketDataModel else {
            return stats
        }

        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)

        let volume = StatisticModel(title: "24h Volume", value: data.volume)

        let btcDom = StatisticModel(title: "BTC Dominance", value: data.btcDom)

        let portfolioValue = StatisticModel(title: "Protfolio View", value: "$0.00", percentageChange: 0)

        stats.append(contentsOf: [marketCap, volume, btcDom, portfolioValue])

        return stats
    }
    
}

private func filteredCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else {
        return coins
    }

    let lowercasedText = text.lowercased()

    let filteredCoins = coins.filter { coin -> Bool in
        coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
    }

    return filteredCoins
}
