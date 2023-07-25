//
//  SplashViewSecond.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/19.
//

import SwiftUI

struct OnBoardingView: View {
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    @StateObject private var viewModel = SplashViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                //TODO: 레이아웃 작업은 추후에 다시 해야함.
                background
                VStack(alignment: .center){
                    Spacer()
                    Image(SplashLogoSecond)
                        .padding(.leading, 55)
                    Spacer()
                    Spacer()
                    Image(SplashImage)
                    Spacer()
                    
                    NavigationLink {
                        getDestination()
                    } label: {
                        Image(SplashOKButton)
                    }
                    
                    Spacer()
                    Spacer()
                }
            }// ZStack
            .onAppear {
                viewModel.fetchUID()
            }
        }// NavigationView
    }// body
    
    var background: some View {
        Image(SplashViewBackground)
            
    }
    
    // 프로필 유무에 따른 분기를 위해 만든 함수.
    @ViewBuilder
    func getDestination() -> some View {
        switch viewModel.goToMainView {
        case true:
            MainView(viewModel: MainViewModel(profile: viewModel.profile))
        case false:
            SetProfileView()
        }
    }
    
    
    struct SplashView_Previews: PreviewProvider {
        static var previews: some View {
            OnBoardingView()
        }
    }
}
