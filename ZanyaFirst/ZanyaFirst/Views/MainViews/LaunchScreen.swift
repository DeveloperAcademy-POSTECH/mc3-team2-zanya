//
//  LaunchScreen.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/26.
//

import SwiftUI

struct LaunchScreen: View {
    
    //MARK: -1. PROPERTY

    //MARK: - 2. BODY
    var body: some View {
        ZStack(alignment: .top){
            Image(LaunchPageSheet)
                .ignoresSafeArea()
            Image(LaunchLogo)
                .padding(.init(top: 328, leading: 0, bottom: 0, trailing: 0.36))
            Button {
                print("start")// TODO: -시작하기 구현하기
            } label: {
                Image(LaunchStartButton)
                    .padding(.top, 728)
                    .shadow(color: .black.opacity(0.15), radius: 5.5, x: 0, y: 4)
            }
        }
    }
}


    //MARK: -3. PREVIEW
struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
