//
//  SettingsView.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 05/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()

    var body: some View {
        NavigationStack {
            List {
                SwiftfulThinkingSection
                CoinGeckoSection
                DeveloperSection
                ApplicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    xmarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var SwiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following @SwiftfulThinking course on Youtube Channel. It uses MVVM Architecture, Combine and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }.padding(.vertical)
            Link("Subscribe on Youtube 🥳", destination: vm.youtubeURL)

        } header: {
            Text("Swiftful Thinking").font(.caption)
        }
    }
    
    private var CoinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes form a free API from CoinGecko! Prices maybe slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }.padding(.vertical)
            Link("Visit CoinGecko 🦎", destination: vm.coingeckoURL )

        } header: {
            Text("CoinGecko").font(.caption)
        }
    }
    
    private var DeveloperSection: some View {
        Section {
            VStack(alignment: .leading) {
                HStack{
                    Image("devImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    VStack(alignment: .leading){
                        Text("@PrashannaR")
                        Text("Native iOS and Android Developer @GDGVIT | Swift | SwiftUI | Kotlin | JetpackCompose")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }
                Text("This app was developed using Swift and SwiftUI as a part of my iOS development learning journey. This app follows MVVM architecture and benefits from multi-threading, combine and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }.padding(.vertical)
            
            HStack{
                Link(destination: vm.githubURL) {
                    Image("github")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                Link(destination: vm.linkedinURL) {
                    Image("linkedin")
                        .resizable()
                        .frame(width: 45, height: 45)
                }
            }
            

        } header: {
            Text("Developer").font(.caption)
        }
    }
    
    private var ApplicationSection: some View {
        Section {
            Link("Terms of Service", destination: vm.coingeckoTerms )
            Link("Privacy Policy", destination: vm.coingeckoPrivacy )
            Link("App Github Link", destination: vm.appGithubURL )
            Link("Course Playlist", destination: vm.playlistURL)

        } header: {
            Text("Application").font(.caption)
        }
    }
}
