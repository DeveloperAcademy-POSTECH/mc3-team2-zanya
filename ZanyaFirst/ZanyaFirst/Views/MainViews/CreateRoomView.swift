//
//  File.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import SwiftUI

struct CreateRoomView: View {
    //MARK: -1. PROPERTY
    @ObservedObject var viewModel = CreateRoomViewModel()
    @State var date = Date()
    @Environment(\.dismiss) private var dismiss

    //MARK: -2. BODY
    var body: some View {
        ZStack {
            CreatePageSheetBG
            Xmark
            VStack{
                ClearRectangle(width: 2, height: screenHeight/6, ClearOn: true)
                CreateRoomTextField
                ClearRectangle(width: 2, height: screenHeight/155, ClearOn: true)
                CreateTimePicker
                Spacer()
                CreateSaveButton
            }
        }
        .navigationBarBackButtonHidden()
    }
}


struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView()
    }
}
extension CreateRoomView {
 
    private var CreatePageSheetBG: some View {
        ZStack {
            Image(CreatePageSheet)
                .ignoresSafeArea()
            VStack{
                Image(CreateRoomTitle)
                    .padding(.top, 50)
                Spacer()
            }
        }
    }
    
    private var Xmark: some View {
        VStack{
            HStack{
                Button {
                    print("어디로 이동하나요?")//TODO: - 어디로 이동하는지는 몰라도 버튼 구현
                    dismiss()
                } label: {
                    Image(CreatePageXmark)
                }
                Spacer()
            }.padding(.horizontal, 20)
                .padding(.top, 64)
            Spacer()
        }

    }
    
    private var CreateRoomTextField: some View {
        ZStack{
            Image(CreateTitleSheet)
            TextField("방 이름을 정해주세요", text: $viewModel.roomName )
                .padding()
                .padding(.top, 25)
        }.frame(width: 297)
    }
    
    //MARK: 이거 색깔 어케바꾸지;;;
    private var CreateTimePicker: some View {
        ZStack{
            Image(CreatePickerSheet)
            DatePicker(selection: $date, displayedComponents: .hourAndMinute){}
                .datePickerStyle(WheelDatePickerStyle())
        }
    }
    
    private var CreateSaveButton: some View {
        VStack{
            Button {
                Text("New Room Created")
                viewModel.clickedCompleteButton()
            } label: {
                Image(CreateRoomSaveButton)
            }
        }.padding(.bottom, screenHeight/20)
    }
    }
    
//    private var roomNameField: some View {
//        TextField("방 이름을 정해주세요", text: $viewModel.roomName )
//            .frame(height: 55)
//            .padding(.leading)
//            .background(Color.gray.opacity(0.4))
//            .cornerRadius(10)
//    }
    
//    private var completeButton: some View {
//        Button {
//            viewModel.clickedCompleteButton()
//        } label: {
//            Text("방 생성 완료!")
//                .font(.headline)
//                .foregroundColor(.white)
//                .frame(height: 55)
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .cornerRadius(10)
//
//        }
////    }
//}
//MARK: -3. PREVIEW
