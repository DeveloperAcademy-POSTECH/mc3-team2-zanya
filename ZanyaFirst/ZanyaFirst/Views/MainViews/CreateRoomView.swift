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
            VStack(spacing: 0){
                CreateRoomTextField
                CreateTimePicker
                Spacer()
                CreateSaveButton
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

//MARK: -3. PREVIEW
struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView()
    }
}

//MARK: -4. EXTENSION
extension CreateRoomView {
    
    private var CreatePageSheetBG: some View {
        ZStack {
            Image(CreatePageSheet)
                .ignoresSafeArea()
            VStack{
                Image(CreateRoomTitle)
                    .padding(.top, 51)
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
            }
            .padding(.init(top: 65, leading: 25, bottom: 0, trailing: 0))
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
            .padding(.init(top: 179, leading: 0, bottom: 24, trailing: 0))
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
        }.padding(.init(top: 0, leading: 0, bottom: 53, trailing: 0))
            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
        
    }
}

