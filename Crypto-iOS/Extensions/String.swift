//
//  String.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 04/06/2023.
//

import Foundation

extension String{
    var removeHTML : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
