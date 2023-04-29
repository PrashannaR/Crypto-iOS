//
//  Double.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 29/04/2023.
//

import Foundation


extension Double{
    
    
    /// Converts a Double intro Currency with 2 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormatter2 : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    
    /// Converts a Double intro Currency as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String{
        let number = NSNumber(value: self) //current number we are accessing
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    
    /// Converts a Double intro Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6 : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    
    /// Converts a Double intro Currency as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyAsDecimals() -> String{
        let number = NSNumber(value: self) //current number we are accessing
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double intro String representation
    /// ```
    /// Convert 1.23456 to  1.23
    /// ```
    func asNumberString() -> String{
        return String(format: "%.2f",self)
    }
    
    
    /// Converts a Double intro String representation of percentage
    /// ```
    /// Convert 1.23456 to  1.23%
    /// ```
    func asPercentString() -> String{
        let number = asNumberString()
        return number + "%"
    }
}
