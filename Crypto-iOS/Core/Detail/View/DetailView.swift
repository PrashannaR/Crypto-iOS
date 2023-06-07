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
    @StateObject private var vm: DetailViewModel

    @State private var showFullDesc: Bool = false

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()

                    description

                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    links


                }
                .padding()
            }
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(vm.coin.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationBarTrailingItems
                }
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(coin: dev.coin)
        }
    }
}

// MARK: Extensions

extension DetailView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticsView(stat: stat)
                }
            }
    }

    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticsView(stat: stat)
                }
            }
    }

    private var NavigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }

    private var description: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDesc ? nil : 3)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)

                    Button {
                        withAnimation(.easeInOut) {
                            showFullDesc.toggle()
                        }
                    } label: {
                        Text(showFullDesc ? "Show Less" : "Show More...")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 5)
                    }.accentColor(.blue)

                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var links : some View{
        VStack(alignment: .leading,spacing: 20){
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }

            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
