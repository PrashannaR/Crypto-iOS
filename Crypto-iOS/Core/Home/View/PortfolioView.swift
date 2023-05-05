//
//  PortfolioView.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 05/05/2023.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantity: String = ""
    @State private var showCheckMark: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchtText: $vm.searchBarText)

                    CoinLogoList

                    if selectedCoin != nil {
                        ProtfolioInputSection
                            .padding()
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    xmarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    navBarButtons
                }
            }
            .onChange(of: vm.searchBarText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

//MARK: Extension
extension PortfolioView {
    private var CoinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ?
                                    Color.theme.green : Color.clear,
                                    lineWidth: 1)
                        }
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }

    private var ProtfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of: \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyAsDecimals() ?? "")
            }

            Divider()

            HStack {
                Text("Amount holding: ")
                Spacer()
                TextField("Ex. 1.4", text: $quantity)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }

            Divider()

            HStack {
                Text("Current Value")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(nil, value: UUID())
    }

    private var navBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantity)) ? 1.0 : 0.0)

        }.font(.headline)
    }

    private func getCurrentValue() -> Double {
        if let quantity = Double(quantity) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }

    private func saveButtonPressed() {
        guard let coin = selectedCoin else {
            return
        }

        // save to portfolio

        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }

        // hide keyboard
        UIApplication.shared.endEditing()

        // hide check
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }

    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchBarText = ""
    }
}
