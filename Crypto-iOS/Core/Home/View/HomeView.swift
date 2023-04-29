//
//  HomeView.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 27/04/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
        ZStack {
            // background
            Color.theme.background
                .ignoresSafeArea()

            // content
            VStack {
                HomeHeader
                
                columnTitle
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                    .padding(.horizontal)

                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }else{
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }
        }
    }
}

// MARK: Extension

extension HomeView {
    private var HomeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(nil, value: UUID())
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .animation(nil, value: UUID())
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        .padding(.horizontal)
    }
    
    private var allCoinsList : some View{
        List {
            // TODO: change the coin later
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList : some View{
        List {
            // TODO: change the coin later
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitle: some View{
        HStack{
            Text("Coin")
            Spacer()
            
            if showPortfolio{
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden, for: .navigationBar)
        }.environmentObject(dev.homeVM)
    }
}


