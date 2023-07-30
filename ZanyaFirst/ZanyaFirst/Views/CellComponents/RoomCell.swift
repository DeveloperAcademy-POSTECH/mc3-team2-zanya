//
//  RoomCell.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/19.
//

import SwiftUI
import UIKit

struct RoomCell: View {
    
    @EnvironmentObject var alertObject: CustomAlertObject
    @State var isClickedOut: Bool = false
    @State var showShare: Bool = false
    @StateObject var viewModel: RoomCellViewModel
    @State var UID: String?
    
    //TODO: -일단 트루놨는데 알람에서 타임 받아서 여기 비워줘야함
    //    var title: String
    //    var userCount: Int
    //    let preFix: String = "zanya-invite:://"
    //    var time: Date
    //TODO: 시간 모델 만들어서 받아야함
    
    var body: some View {
        
        if viewModel.isOnTime == true {
            ZStack{
                roomCellSheet
                leftView
                rightView
            }
            .frame(width: 304, height: 160)
        } else {
            //IsOnTime = false
            ZStack{
                roomCellSheet
                leftView
                rightView
            }
            .frame(width: 304, height: 160)
        }
    }// body
    
    var leftView: some View {
        VStack(alignment: .leading, spacing: 0) {
            StrokedTextCellLeading(text: viewModel.title, size: 19,
                                   color: viewModel.isOnTime ? .white : Color(AppLavender),
                                   strokeColor: viewModel.isOnTime ? AppWine : Apppurple)
            Spacer()
            TextCell(text: "오전", size: 16, color: viewModel.isOnTime ? Color(AppWine) : Color(Apppurple))
                .padding(EdgeInsets(top: 0, leading: 3, bottom: 5, trailing: 0))
            StrokedTimeCell(text: "11:00", size: 40,
                            color: viewModel.isOnTime ? Color(AppWine) : Color(Apppurple),
                            strokeColor: AppWhite)
            .offset(x:-87,y:0)
        }
        .padding(EdgeInsets(top: 22, leading: 22, bottom: 24, trailing: 0))
    }
    
    var rightView: some View {
        VStack(alignment: .trailing, spacing: 0) {
            roomOutButton
            Spacer()
            roomInviteButton
                .padding(.leading, 194)
        }
        .padding(EdgeInsets(top: 22, leading: 0, bottom: 24, trailing: 22))
    }
    
    var roomCellSheet: some View {
        Image(viewModel.isOnTime ? RoomCellSheetPink : RoomCellSheetBlue)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var roomOutButton: some View {
        Button {
            alertObject.isClicked = true
            alertObject.roomName = viewModel.title
            alertObject.room = viewModel.room
            alertObject.UID = self.UID
            print("Room \(viewModel.title) Out!")
        } label: {
            Image(viewModel.isOnTime ? RoomBoxOutPink : RoomBoxOutBlue)
        }
    }
    
    var roomInviteButton: some View {
        Button {
            print("공유하기 작동") //TODO: -공유하기 기능 추가해야함
            showShare.toggle()
        } label: {
            ZStack(alignment: .center){
                Image(viewModel.isOnTime ? InvitePinkBtn : InviteBlueBtn)
                HStack(spacing: 5){
                    Image(viewModel.isOnTime ? InviteTextPink : InviteTextBlue)
                    TextCell(text: "\(viewModel.userCount)/6", size: 12, color: .white, weight: "Regular")
                }
                .frame(width: 82)
            }
        }
        .sheet(
            isPresented: $showShare,
            onDismiss: {
                showShare = false
                print("\(showShare) onDismiss") },
            content: {
                ActivityView(text: viewModel.preFix + viewModel.title)
                    .presentationDetents([.medium, .large])
            }
        )// Sheet
    }
}

struct RoomCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RoomCell(viewModel: RoomCellViewModel(isOnTime: dummyRoomCellViewModel.isOnTime, room: dummyRoom0))
                .previewLayout(.sizeThatFits)
                .environmentObject(CustomAlertObject())
            RoomCell(viewModel: RoomCellViewModel(isOnTime: false, room: dummyRoom0))
                .previewLayout(.sizeThatFits)
                .environmentObject(CustomAlertObject())
        }
    }
}

struct ActivityView: UIViewControllerRepresentable{
    let text: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> some UIViewController {
        return UIActivityViewController(activityItems: [text], applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
