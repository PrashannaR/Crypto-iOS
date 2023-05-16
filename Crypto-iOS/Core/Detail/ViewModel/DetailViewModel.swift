//
//  DetailViewModel.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 17/05/2023.
//

import Foundation
import Combine
class DetailViewModel : ObservableObject{
    private let coinDetailService : CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    //MARK: Subscribers
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .sink{ returnedCoinDetails in
                print("recived data: \(returnedCoinDetails)")
            }
            .store(in: &cancellables)
    }
}
