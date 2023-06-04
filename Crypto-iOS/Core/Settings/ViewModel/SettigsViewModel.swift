//
//  SettigsViewModel.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 05/06/2023.
//

import Foundation


class SettingsViewModel : ObservableObject{
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let playlistURL = URL(string: "https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu")!
    
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let coingeckoPrivacy = URL(string: "https://www.coingecko.com/en/privacy")!
    let coingeckoTerms = URL(string: "https://www.coingecko.com/en/terms")!
    
    let githubURL = URL(string: "https://github.com/PrashannaR")!
    let linkedinURL = URL(string: "https://www.linkedin.com/in/prashannar/")!
    let appGithubURL = URL(string: "https://github.com/PrashannaR/Crypto-iOS")!
}
