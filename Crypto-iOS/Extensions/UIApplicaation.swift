//
//  UIApplicaation.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 02/05/2023.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

