//
//  CircleButtonAnimationView.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 28/04/2023.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    //@Binding var animate: Bool
    @State var animate: Bool = false
    @State var animAmt : Int = 1
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0  : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeOut(duration: 1.0) : .none, value: animAmt)
            .onAppear{
                animate.toggle()
                animAmt += 1
            }
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView()
    }
}
