//
//  File.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import SwiftUI

struct UpdateProfileView: View {
    
    //MARK: -1. PROPERTY
    @StateObject var viewModel: UpdateProfileViewModel
    @Binding var path: NavigationPath
    
    let profileArray = ProfileImageArray
    let setProfileImageArray = SetProfileImageArray
    
    //MARK: -2. BODY
    var body: some View {
        VStack {
            ZStack{
                UpdateProfileBackground
                Chevron
                VStack {
                    ClearRectangle(width: 2, height: screenHeight/6, ClearOn: true)
                    catArray
                    textField
                    Spacer()
                    saveButton
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            viewModel.fetchUID()
        }
    }
}

    //MARK: -3. PREVIEW

//    //TODO: UpdateProfileViewModel에 Delegate변수 어케 넣을지 모르겠어서 걍 안보고 함
//struct UpdateProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//    }
//}
    //MARK: -4. EXTENSION
extension UpdateProfileView {
    
    private var UpdateProfileBackground: some View {
            Image(SetProfileBackgroundSheet)
                .resizable()
                .ignoresSafeArea()
        
    }

    private var catArray: some View{
        VStack(alignment: .center, spacing: 0) {
            ForEach(setProfileImageArray, id: \.self) { catsRow in
                HStack(alignment: .center, spacing: 0){
                    ForEach(catsRow, id: \.self) { cat in
                        ZStack{
                            Image(viewModel.profileImage == cat ? ProfileCircleOn : ProfileCircleOff)
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
            //TODO: - 이름숫자쓰는거 해야함
            TextField(viewModel.profileName, text: $viewModel.profileName )
                .padding(.horizontal)
        }.frame(width: 297)
            .padding(.vertical,10)
    }
    private var saveButton: some View{
        ZStack{
            Button {
                viewModel.clickedSaveButton()
            } label: {
                Image(updateProfileSaveButton)
            }
        }.padding(.bottom, screenHeight/20)
    }
    private var Chevron: some View {
        VStack{
            HStack{
                Button {
                    path.removeLast()
                } label: {
                    Image(SetPageChevron)
                }
                Spacer()
            }.padding(.horizontal, 20)
                .padding(.top, 64)
            Spacer()
        }
        
    }
    
    //MARK: 안쓰는 셋버튼
//    private var setButton: some View {
//        Button {
//            viewModel.nextButtonPressed()
//        } label: {
//            Text("다음")
//                .font(.headline)
//                .foregroundColor(.white)
//                .frame(height: 55)
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .cornerRadius(10)
//
//        }
//    }
}
