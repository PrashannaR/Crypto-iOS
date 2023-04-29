//
//  Crypto_iOSApp.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 27/04/2023.
//

import SwiftUI

@main
struct Crypto_iOSApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }.environmentObject(vm)
        }
    }
}
