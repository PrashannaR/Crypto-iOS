//
//  StatisticsView.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 05/05/2023.
//

import SwiftUI

struct StatisticsView: View {
    let stat: StatisticModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 4){
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticsView(stat: dev.statOne)
            StatisticsView(stat: dev.statTwo)
            StatisticsView(stat: dev.statThree)
        }
    }
}
