//
//  MarketDataModel.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 05/05/2023.
//

import Foundation

// JSON Data
/*

 url: https://api.coingecko.com/api/v3/global

 response:
 {
   "data": {
     "active_cryptocurrencies": 10681,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 727,
     "total_market_cap": {
       "btc": 42787535.69371524,
       "eth": 658457256.8254936,
       "ltc": 14057574831.90408,
       "bch": 10562213310.619192,
       "bnb": 3807359885.029584,
       "eos": 1230195037440.2744,
       "xrp": 2688418786072.815,
       "xlm": 13247643201367.16,
       "link": 177090547809.1217,
       "dot": 219040434697.74704,
       "yfi": 154154568.46485302,
       "usd": 1235663973501.155,
       "aed": 4537852376285.631,
       "ars": 278853524563979.5,
       "aud": 1845795302368.877,
       "bdt": 131544150407704.52,
       "bhd": 465879916601.1925,
       "bmd": 1235663973501.155,
       "brl": 6166333926962.816,
       "cad": 1672754155183.7488,
       "chf": 1094452294609.4446,
       "clp": 985985711015512.4,
       "cny": 8534236799383.101,
       "czk": 26273737718959.047,
       "dkk": 8355755023722.634,
       "eur": 1121596125115.3455,
       "gbp": 982440591075.5365,
       "hkd": 9696635784567.43,
       "huf": 418479465993185.5,
       "idr": 18171702094187304,
       "ils": 4515795774358.644,
       "inr": 100985247416721.11,
       "jpy": 165775362381510.84,
       "krw": 1635969779388028.8,
       "kwd": 378459161803.93414,
       "lkr": 394721807027693.4,
       "mmk": 2594143568514432.5,
       "mxn": 22130540352178.043,
       "myr": 5502411674000.655,
       "ngn": 570876755757532.2,
       "nok": 13203156053337.982,
       "nzd": 1966104489484.8403,
       "php": 68491619622859.75,
       "pkr": 350681435679628.4,
       "pln": 5147333745903.305,
       "rub": 96996702045871.48,
       "sar": 4633915364913.589,
       "sek": 12649850439283.639,
       "sgd": 1640937043530.067,
       "thb": 41724549240800.04,
       "try": 24091382148799.746,
       "twd": 37946621558569.766,
       "uah": 45626322580438.51,
       "vef": 123727033666.6708,
       "vnd": 28978987838726520,
       "zar": 22610299246529.574,
       "xdr": 915269897476.0131,
       "xag": 47484441159.615,
       "xau": 603164655.3851187,
       "bits": 42787535693715.234,
       "sats": 4278753569371523.5
     },
     "total_volume": {
       "btc": 3080020.5473908447,
       "eth": 47398426.84838283,
       "ltc": 1011921313.6901608,
       "bch": 760310999.3411133,
       "bnb": 274069223.363224,
       "eos": 88554433696.23267,
       "xrp": 193523299878.00793,
       "xlm": 953619146397.972,
       "link": 12747696663.46809,
       "dot": 15767419848.803722,
       "yfi": 11096671.74442243,
       "usd": 88948109919.15086,
       "aed": 326653038867.08887,
       "ars": 20073008913564.72,
       "aud": 132867840257.7104,
       "bdt": 9469082048684.393,
       "bhd": 33535927986.597538,
       "bmd": 88948109919.15086,
       "brl": 443877752929.5387,
       "cad": 120411635892.74243,
       "chf": 78783119917.59041,
       "clp": 70975254828887.28,
       "cny": 614329015967.609,
       "czk": 1891290318994.4177,
       "dkk": 601481173074.666,
       "eur": 80737043048.18446,
       "gbp": 70720062701.52917,
       "hkd": 698003214553.4338,
       "huf": 30123851094081.14,
       "idr": 1308072898420814.5,
       "ils": 325065315105.03253,
       "inr": 7269328134560.814,
       "jpy": 11933183673889.729,
       "krw": 117763747169148.45,
       "kwd": 27243027106.03755,
       "lkr": 28413678339673.88,
       "mmk": 186736986937059.3,
       "mxn": 1593046150110.078,
       "myr": 396085933469.9796,
       "ngn": 41094026782647.59,
       "nok": 950416780853.8209,
       "nzd": 141528184031.8784,
       "php": 4930304873656.741,
       "pkr": 25243473595055.055,
       "pln": 370525982499.83185,
       "rub": 6982216444269.618,
       "sar": 333568042828.42566,
       "sek": 910587596194.2239,
       "sgd": 118121311010.43419,
       "thb": 3003502466517.638,
       "try": 1734195504141.8105,
       "twd": 2731551892614.0547,
       "uah": 3284367953685.9834,
       "vef": 8906374246.204586,
       "vnd": 2086025206611215.5,
       "zar": 1627581143267.2854,
       "xdr": 65884843446.32408,
       "xag": 3418122873.4439087,
       "xau": 43418240.8948351,
       "bits": 3080020547390.8447,
       "sats": 308002054739084.44
     },
     "market_cap_percentage": {
       "btc": 45.25676855665301,
       "eth": 18.281585239710076,
       "usdt": 6.634128868443853,
       "bnb": 4.1464573927918,
       "usdc": 2.4389750077121852,
       "xrp": 1.925476893549107,
       "ada": 1.0990503727877345,
       "steth": 0.95294724670676,
       "doge": 0.8865886965221101,
       "matic": 0.7366503367268422
     },
     "market_cap_change_percentage_24h_usd": 0.8503946354403287,
     "updated_at": 1683229357
   }
 }

 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }

    var marketCap: String {
        if let item = totalMarketCap.first(where: { key, _ -> Bool in
            key == "usd"
        }) {
            return "$\(item.value.formattedWithAbbreviations())"
        }

        return ""
    }

    var volume: String {
        if let item = totalVolume.first(where: { key, _ -> Bool in
            key == "usd"
        }) {
            return "$\(item.value.formattedWithAbbreviations())"
        }

        return ""
    }

    var btcDom: String {
        if let item = marketCapPercentage.first(where: { key, _ in
            key == "btc"
        }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
