//
//  HomeViewModel.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 29/04/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchBarText : String = ""
    
    private let dataService = CoinDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscriber()
    }
    
    func addSubscriber(){
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
