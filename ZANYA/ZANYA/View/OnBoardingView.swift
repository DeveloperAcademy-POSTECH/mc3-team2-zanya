//
//  OnBoardingView.swift
//  ZANYA
//
//  Created by 박승찬 on 2023/07/18.
//

import SwiftUI

struct OnBoardingView: View {
    
    @StateObject private var viewModel = OnBoardingViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                nextButton
                    .background(
                        NavigationLink(destination: SetProfileView(),isActive: $viewModel.goToSetProfileView){
                        
                    })
            }
        }
    }
}

extension OnBoardingView {
    private var nextButton: some View {
        Button {
            viewModel.nextButtonPressed()
        } label: {
            Text("알겠다냥")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                
        }
    }
}
