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
            
            ZStack(alignment: .top){
                Image(LaunchPageSheet)
                    .ignoresSafeArea()
                Image(LaunchLogo)
                    .padding(.init(top: 328, leading: 0, bottom: 0, trailing: 0.36))
                NavigationLink {
                    getDestination()
                } label: {
                    Image(LaunchStartButton)
                        .padding(.top, 728)
                        .shadow(color: .black.opacity(0.15), radius: 5.5, x: 0, y: 4)
                }
            }
            .onAppear {
                viewModel.fetchUID()
            }
            .onOpenURL { url in
                var link = url.absoluteString.removingPercentEncoding!
                print("roomURL: \(link.replacingOccurrences(of: "zanya-invite:://", with: ""))")
                viewModel.addRoom(url: link.replacingOccurrences(of: "zanya-invite:://", with: ""))
            }
        }// NavigationView
    }// body
    
    var background: some View {
        Image(LaunchPageSheet)
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

extension String {
    func remove(target string: String) -> String {
        return components(separatedBy: string).joined()
    }
}
