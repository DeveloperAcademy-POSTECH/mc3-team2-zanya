//
//  OnBoardingViewModel.swift
//  ZANYA
//
//  Created by 박승찬 on 2023/07/18.
//

import Foundation

class OnBoardingViewModel: ObservableObject {
    
    @Published var goToSetProfileView: Bool = false
    
    
    func nextButtonPressed() {
        DispatchQueue.main.async {
            self.goToSetProfileView = true
            print("다음 버튼")
        }
    }
}
