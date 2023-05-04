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

    private let dataService = CoinDataService()

    private var cancellables = Set<AnyCancellable>()
    
    
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentageChange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentageChange: -1),
    ]

    init() {
        addSubscriber()
    }

    func addSubscriber() {
        
        //updates allCoins
        $searchBarText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .map(filteredCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filteredCoins(text: String, coins:[CoinModel]) -> [CoinModel]{
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
}
