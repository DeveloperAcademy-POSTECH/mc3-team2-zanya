//
//  File.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import SwiftUI

struct UpdateProfileView: View {
    
    //MARK: -1. PROPERTY
    @StateObject var viewModel : UpdateProfileViewModel
    @Binding var path: NavigationPath
    
    let profileArray = ProfileImageArray
    let setProfileImageArray = SetPrifileCatArray
    
    //MARK: -2. BODY
    var body: some View {
        NavigationView {
            ZStack{
                SetProfileBackground
                Chevron
                VStack(spacing: 0) {
                    catArray
                    textField
                    Spacer()
                    saveButton
                }
            }.ignoresSafeArea()
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
//        UpdateProfileView( path: .constant(NavigationPath()))
//    }
//}
    //MARK: -4. EXTENSION
extension UpdateProfileView {
    
    private var SetProfileBackground: some View {
        ZStack {
            Image(SetProfileBackgroundSheet)
                .ignoresSafeArea()
            VStack{
                Image(updateProfileTitle)
                    .padding(.top, 51)
                Spacer()
            }
        }
    }

    private var catArray: some View{
        VStack(spacing: 0) {
            ForEach(setProfileImageArray, id: \.self) { catRow in
                HStack(spacing: 0) {
                    ForEach(catRow, id: \.self) { cat in
                        Button {
                            print("")
                        } label: {
                            Button {
                                print("d")
                            } label: {
                                ZStack{
                                    Image(ProfileCircleOff)
                                    //TODO: - on/off 바뀌여면 뷰모델에 catName추가되어야 함/없어서 일단 off로 해둠
                                        .frame(width: 82, height: 82)
                                    Image(cat)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 56)
                                }.padding(7)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 46)
        .padding(.init(top: 86, leading: 0, bottom: 0, trailing: 0))
    }
    private var textField: some View{
        ZStack{
            Image(SetProfileTextField)
                .resizable()
                .aspectRatio(contentMode: .fit)
            //TODO: - 이름숫자쓰는거 해야함
            TextField("닉네임", text: $viewModel.profileName )
                .padding(.horizontal)
        }.frame(width: 297)
//            .padding(EdgeInsets(top: 7, leading: 46, bottom: 0, trailing: 46))
    }
    private var saveButton: some View{
        ZStack{
            Button {
                viewModel.clickedSaveButton()
            } label: {
                Image(updateProfileSaveButton)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
            }
        }.padding(.bottom, 57)
    }
    private var Chevron: some View {
        VStack{
            HStack{
                Button {
                    print("메인페이지로 이동")//TODO: - 네비게이션 백버튼
                } label: {
                    Image("SetPageChevron")
                        .padding(.init(top: 65, leading: 25, bottom: 0, trailing: 0))
                }
                Spacer()
            }
            Spacer()
        }
    }
}
