//
//  RoomCell.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/19.
//

import SwiftUI
import UIKit

struct RoomCell: View {
    
    var isOnTime: Bool = true //TODO: -일단 트루놨는데 알람에서 타임 받아서 여기 비워줘야함
    var title: String

//    var time: Date
    var userCount: Int

    let preFix: String = "zanya-invite:://"
    
    @State var isClickedOut: Bool = false
    @State var showShare: Bool = false
    
    //    var time: Date
    //TODO: 시간 모델 만들어서 받아야함
    
    var body: some View {
        
        if isOnTime == true {
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
            StrokedTextCellLeading(text: title, size: 19,
                                   color: isOnTime ? .white : Color(AppLavender),
                                   strokeColor: isOnTime ? AppWine : Apppurple)
            Spacer()
            TextCell(text: "오전", size: 16, color: isOnTime ? Color(AppWine) : Color(Apppurple))
                .padding(EdgeInsets(top: 0, leading: 3, bottom: 5, trailing: 0))
            StrokedTimeCell(text: "11:00", size: 40,
                            color: isOnTime ? Color(AppWine) : Color(Apppurple),
                            strokeColor: AppWhite)
                .offset(x:-87,y:0)
        }
        .padding(EdgeInsets(top: 22, leading: 22, bottom: 24, trailing: 0))
//        .border(.red)
    }
    
    var rightView: some View {
        VStack(alignment: .trailing, spacing: 0) {
            roomOutButton
            Spacer()
            roomInviteButton
                .padding(.leading, 194)
        }
        .padding(EdgeInsets(top: 22, leading: 0, bottom: 24, trailing: 22))
        .confirmationDialog("방을 나가게 됩니다.", isPresented: $isClickedOut, titleVisibility: .visible){
            Button("나가기", role: .destructive){
                //TODO: 방나가기 액션
            }
        }
    }
    
    var roomCellSheet: some View {
        Image(isOnTime ? RoomCellSheetPink : RoomCellSheetBlue)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var roomOutButton: some View {
        Button {
            print("dd")
            isClickedOut = true
        } label: {
            Image(isOnTime ? RoomBoxOutPink : RoomBoxOutBlue)
        }
    }
    
    var roomInviteButton: some View {
        Button {
            print("공유하기 작동") //TODO: -공유하기 기능 추가해야함
            showShare.toggle()
        } label: {
            ZStack(alignment: .center){
                Image(isOnTime ? InvitePinkBtn : InviteBlueBtn)
                HStack(spacing: 5){
                    Image(isOnTime ? InviteTextPink : InviteTextBlue)
                    TextCell(text: "\(userCount)/6", size: 12, color: .white, weight: "Regular")
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
                ActivityView(text: preFix + title)
                    .presentationDetents([.medium, .large])
            }
        )// Sheet
    }
}

struct RoomCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RoomCell(isOnTime: true, title: "일어날래 나랑살래?", userCount: 0)
                .previewLayout(.sizeThatFits)
            RoomCell(isOnTime: false, title: "일어날래 나랑살래?", userCount: 0)
                .previewLayout(.sizeThatFits)
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
