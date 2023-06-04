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
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes =  [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes =  [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }.environmentObject(vm)
        }
    }
}
