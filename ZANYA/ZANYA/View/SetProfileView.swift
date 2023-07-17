//
//  SetProfileView.swift
//  ZANYA
//
//  Created by 박승찬 on 2023/07/18.
//

import SwiftUI

struct SetProfileView: View {
    
    @StateObject private var viewModel = SetProfileViewModel()
    
    let cats : [[String]] = [["blueCat","scotCat","oddCat"],["blackCat","blueCat","shamCat"]]
    
    var body: some View {
        VStack{
            header
            catsBtn
            textField
            Spacer()
            completeButton
        }
    }
}

struct SetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetProfileView()
    }
}

extension SetProfileView {
    private var header: some View {
        Text("프로필을 정해주세요.")
            .font(.headline)
            .underline()
    }
    
    private var catsBtn: some View {
        ForEach(self.cats, id: \.self){ catsRaw in
            HStack{
                ForEach(catsRaw, id: \.self){ cat in
                    Button {
                        viewModel.clickedCatBtn(cat)
                    } label: {
                        Image(cat)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
            }
        }
    }
    
    private var completeButton: some View {
        Button {
            viewModel.completeButtonPressed()
        } label: {
            Text("완료")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                
        }
    }
    
    private var textField: some View {
        TextField("닉네임", text: $viewModel.userName )
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
}
