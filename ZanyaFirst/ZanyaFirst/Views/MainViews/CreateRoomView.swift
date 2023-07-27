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
    @State var isClickedComBut: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    //MARK: -2. BODY
    var body: some View {
        ZStack {
            CreatePageSheetBG
            Xmark
            VStack(spacing: 0) {
                CreateRoomTextField
                CreateTimePicker
                Spacer()
                CreateSaveButton
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .alert(isPresented: $isClickedComBut) {
            Alert(title: Text("방이 생성되었습니다"), dismissButton: .default(Text("OK")) {})
        }
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
            //TODO: -피커 가운데 바 노랗게 하는건 모르겠음
            VStack {
                DatePicker(selection: $date, displayedComponents: .hourAndMinute){}
                    .datePickerStyle(WheelDatePickerStyle())
                    .colorInvert()
                    .colorMultiply(Color(AppWine))
            }.frame(width: 198.5)
                .padding(.trailing, 8)
                .padding(.top, 15)
                .foregroundColor(.FontRed)
        }
    }
    
    private var CreateSaveButton: some View {
        VStack{
            Button {
                Text("New Room Created")
                isClickedComBut = true
                viewModel.clickedCompleteButton()
            } label: {
                Image(CreateRoomSaveButton)
            }
        }
        .padding(.init(top: 0, leading: 0, bottom: 53, trailing: 0))
        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
        
    }
}

