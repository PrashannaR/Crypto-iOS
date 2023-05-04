//
//  HomeStatsView.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 05/05/2023.
//

import SwiftUI

struct HomeStatsView: View {

    
    @Binding var showPortfolio: Bool
    @EnvironmentObject private var vm : HomeViewModel
    
    var body: some View {
        HStack{
            ForEach(vm.statistics){ stat in
                StatisticsView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width,alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
