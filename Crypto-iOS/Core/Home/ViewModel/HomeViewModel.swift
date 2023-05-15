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

    @Published var isLoading: Bool = false

    @Published var sortOption: SortOption = .holdings

    init() {
        addSubscriber()
    }

    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }

    // MARK: Add subscribers

    func addSubscriber() {
        // updates allCoins
        $searchBarText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .map(filteredAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)

        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink {[weak self] returnedCoins in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)

        // this updates the market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] recivedState in
                self?.statistics = recivedState
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }

    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
    }

    // MARK: Update CoreData

    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }

    // MARK: Market data

    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []

        guard let data = marketDataModel else {
            return stats
        }

        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)

        let volume = StatisticModel(title: "24h Volume", value: data.volume)

        let btcDom = StatisticModel(title: "BTC Dominance", value: data.btcDom)

        let portfolioValue = portfolioCoins.map { coin -> Double in
            coin.currentHoldingsValue
        }.reduce(0, +)

        let previousValue =
            portfolioCoins.map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentageChage = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentageChage)

                return previousValue
            }.reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue)

        let portfolio = StatisticModel(title: "Protfolio View", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)

        stats.append(contentsOf: [marketCap, volume, btcDom, portfolio])

        return stats
    }

    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }

    //MARK: Filter and Sort Coins
    private func filteredAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filteredCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }

    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort { coinOne, coinTwo -> Bool in
                coinOne.rank < coinTwo.rank
            }
        case .rankReversed, .holdingsReversed:
            coins.sort { coinOne, coinTwo -> Bool in
                coinOne.rank < coinTwo.rank
            }
        case .price:
            coins.sort { coinOne, coinTwo -> Bool in
                coinOne.currentPrice > coinTwo.currentPrice
            }
        case .priceReversed:
            coins.sort { coinOne, coinTwo -> Bool in
                coinOne.currentPrice < coinTwo.currentPrice
            }
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel]{
        //will only sort by holdings and it's reversed if needed
        switch sortOption{
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
    }

    // MARK: Filter coins

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
}
