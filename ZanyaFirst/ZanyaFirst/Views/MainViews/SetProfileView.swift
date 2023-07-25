//
//  SetNameView.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import SwiftUI

struct SetProfileView: View {
    
    //TODO: 입력된 프로필을 Cloud에 올리는 로직 작업 필요. 버튼 클릭시 로그는 찍힘.
    
    //MARK: -1. PROPERTY
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SetProfileViewModel()
    
    let profileArray = ProfileImageArray
    let setProfileImageArray = SetProfileImageArray
    
    //MARK: -2. BODY
    var body: some View {
        NavigationView {
            ZStack{
                SetProfileBackground
                dismissButton
                
                // 키보드가 올라올 때 뷰를 미는 걸 방지하기 위해 Geometry 사용함.
                GeometryReader { geo in
                    VStack(alignment: .center, spacing: 0) {
                        Spacer()
                            .frame(height: 102)
                        catArray
                        textField
                        Spacer()
                        completeButton
                            .background(
                                NavigationLink(destination: MainView(viewModel: MainViewModel(profile: viewModel.profile)),isActive: $viewModel.goToMainView){
                            })
                    }// VStack
                    .padding(.top, UIApplication.shared.windows[0].safeAreaInsets.top)
                }
            }// ZStack
            .ignoresSafeArea()
        }// NavigationView
        .navigationBarBackButtonHidden()
        .onAppear{
            print("user name: \(viewModel.name)")
        }
    }// body
}// SetProfileView

//MARK: -3. PREVIEW
struct SetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetProfileView()
    }
}

extension SetProfileView {
    private var dismissButton: some View {
        VStack{
            HStack{
                Button {
                    print("dismiss")
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.FontTeal)
                }// label
                Spacer()
            }// HStack
            .padding(.leading, 24)
            .padding(.top, 65)
            Spacer()
        }// VStack
    }// dismissButton
    
    private var SetProfileBackground: some View {
        Image(SetProfileBackgroundSheet)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }// SetProfileBackground
    
    private var catArray: some View{
        VStack(alignment: .center, spacing: 0) {
            ForEach(setProfileImageArray, id: \.self) { catsRow in
                HStack(alignment: .center, spacing: 0){
                    ForEach(catsRow, id: \.self) { cat in
                        ZStack{
                            Image(viewModel.catName == cat ? ProfileCircleOn : ProfileCircleOff)
                            Image(cat)
                                .resizable()
                                .frame(width: 56.08, height: 46.12)
                        }
                        .onTapGesture {
                            viewModel.clickedCatBtn(cat)
                            print("\(cat) is selected")
                        }
                        .padding(7)
                    }// cat ForEach
                }// HStack
            }// catsRow ForEach
        }// VStack
        .padding(.horizontal, 46)
    }// catArray
    
    private var textField: some View{
        ZStack{
            Image(SetProfileTextField)
                .resizable()
                .aspectRatio(contentMode: .fit)
            //TODO: - 입력 카운트 및, 전체 삭제 버튼(optional한 작업. 공수 남으면 진행)
            TextField("닉네임", text: $viewModel.name)
                .padding(.horizontal)
        }
        .padding(EdgeInsets(top: 7, leading: 46, bottom: 0, trailing: 46))
    }
    
    private var completeButton: some View{
        Button {
            print("name: \(viewModel.name), cat: \(viewModel.catName)")
            viewModel.completeButtonPressed()
        } label: {
            Image(viewModel.name == "" ? "SetProfileCompleteButton_disabled" : SetProfileCompleteButton)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 0, leading: 22, bottom: 51, trailing: 22))
                .shadow(color: .black.opacity(0.15), radius: 5.5, x: 0, y: 4)
        }
        .disabled(viewModel.name == "" ? true : false)
    }
}


