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
    @State private var showLaunchView : Bool = true

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = UIColor.clear
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                }.environmentObject(vm)
                
                ZStack{
                    if showLaunchView{
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
                
            }
        }
    }
}
