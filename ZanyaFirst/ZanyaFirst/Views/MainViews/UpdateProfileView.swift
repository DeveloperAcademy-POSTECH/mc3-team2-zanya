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
    // @Binding var path: NavigationPath
    
    let profileArray = ProfileImageArray
    let setProfileImageArray = SetPrifileCatArray
    @Environment(\.dismiss) private var dismiss
    
    //MARK: -2. BODY
    var body: some View {
        VStack {
            ZStack{
                UpdateProfileBackground
                Chevron
                VStack(spacing: 0) {
                    Spacer()
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

    //TODO: UpdateProfileViewModel에 Delegate변수 어케 넣을지 모르겠어서 걍 안보고 함
struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(profile: dummyProfile4))
            .environmentObject(LocalNotificationManager())
    }
}
    //MARK: -4. EXTENSION
extension UpdateProfileView {
    
    private var UpdateProfileBackground: some View {
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
        VStack(alignment: .center, spacing: 0) {
            ForEach(setProfileImageArray, id: \.self) { catsRow in
                HStack(alignment: .center, spacing: 0){
                    ForEach(catsRow, id: \.self) { cat in
                        ZStack{
                            Image(viewModel.profileImage == cat ? ProfileCircleOn : ProfileCircleOff)
                            Image(cat)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 56)
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
            //TODO: - 이름숫자쓰는거 해야함
            TextField(viewModel.profileName, text: $viewModel.profileName )
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
                    dismiss()
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
