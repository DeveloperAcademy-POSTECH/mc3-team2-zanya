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
    let preFix: String = "zanya-invite:://"
    
    @State var isClickedOut: Bool = false
    @State var showShare: Bool = false
    
    //    var time: Date
    //TODO: 시간 모델 만들어서 받아야함
    
    var body: some View {
        
        if isOnTime == true {
            ZStack{
                roomCellSheet
                //                VStack(spacing: 0){
                //                    HStack(alignment: .center,spacing: 0){
                //                        //Room Title
                //                        StrokedTextCellLeading(text: title, size: 19, strokeColor: AppWine)
                //                        Spacer()
                //                        roomOutButton
                //                    }
                //                    .padding(.init(top: 21, leading: 15, bottom: 0, trailing: 18))
                //                    .frame(width: 300)
                //                    .confirmationDialog("방을 나가게 됩니다.", isPresented: $isClickedOut, titleVisibility: .visible){
                //                        Button("나가기",role: .destructive){
                //                            //TODO: 방나가기 액션
                //                        }
                //                    }
                //
                //                    HStack(spacing: 0){
                //                        //Time
                //                        VStack(alignment: .leading, spacing: 0){
                //                            //TODO: -DATEMODEL로 바까야함
                //                            TextCell(text: "오전", size: 14, color: Color(AppWine))
                //                                .padding(.init(top: -3, leading: -8, bottom: 5, trailing: 0))
                //
                //                            HStack {
                //                                //TODO: -DATEMODEL로 바까야함
                //                                StrokedTimeCell(text: "11:00", size: 40, color: Color(AppWine), strokeColor: AppWhite)
                //                                    .padding(.init(top: -4, leading: -47, bottom: -3, trailing: 0))
                //                                Spacer()
                //                            }
                //                        }
                //                        .padding(.init(top: 25, leading: 24, bottom: 0, trailing: 0))
                //
                //                        Spacer()
                //
                //                        VStack(alignment: .trailing){
                //
                //                            Spacer()
                //
                //                            //친구를 초대해보세요
                //                            Image(InviteTalkBox)
                //                                .padding(.init(top: 0, leading: 0, bottom: -8, trailing: 16))
                //                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
                //                            //InviteButton
                //                            roomInviteButton
                //                            .sheet(
                //                                isPresented: $showShare,
                //                                onDismiss: {
                //                                    showShare = false
                //                                    print("\(showShare) onDismiss") },
                //                                content: {
                //                                    ActivityView(text: preFix + title)
                //                                        .presentationDetents([.medium, .large])
                //                                }
                //                            )// Sheet
                //                        }
                //                    }
                //                    .frame(width: 300)
                //                }
                
                leftView
                rightView
            }
            .frame(width: 304, height: 160)
        } else {
            //IsOnTime = false
            ZStack{
                roomCellSheet
//                VStack(spacing: 0){
//                    HStack(alignment: .center, spacing: 0){
//                        //Room Title
//                        StrokedTextCellLeading(text: title, size: 19, color: Color(AppLavender), strokeColor: Apppurple)
//
//                        Spacer()
//
//                        //OutButton
//                        roomOutButton
//                    }
//                    .padding(.init(top: 21, leading: 15, bottom: 0, trailing: 18))
//                    .frame(width: 300)
//                    .confirmationDialog("방을 나가게 됩니다.", isPresented: $isClickedOut, titleVisibility: .visible){
//                        Button("나가기",role: .destructive){
//                            //TODO: 방나가기 액션
//                        }
//                    }
//                    .border(.red)
//
//                    HStack(spacing: 0){
//                        //Time
//                        VStack(alignment: .leading, spacing: 0){
//                            //TODO: -DATEMODEL로 바까야함
//                            TextCell(text: "오전", size: 14, color: Color(Apppurple))
//                                .padding(.init(top: -3, leading: -8, bottom: 5, trailing: 0))
//
//                            HStack {
//                                //TODO: -DATEMODEL로 바까야함
//                                StrokedTimeCell(text: "11:00", size: 40, color: Color(Apppurple), strokeColor: AppWhite)
//                                    .padding(.init(top: -4, leading: -47, bottom: -3, trailing: 0))
//
//                                Spacer()
//
//                            }
//                        }
//                        .padding(.init(top: 25, leading: 24, bottom: 0, trailing: 0))
//                        .border(.black)
//
//                        Spacer()
//
//                        VStack(alignment: .trailing){
//                            Spacer()
//                            ClearRectangle(width: 130, height: 40,ClearOn: true)
//                            //InviteButton
//                            roomInviteButton
//                        }
//                        .border(.green)
//                    }
//                    .frame(width: 300)
//                    .border(.blue)
//                }
                
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
                    TextCell(text: "0/6", size: 12, color: .white, weight: "Regular")
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
            RoomCell(isOnTime: true, title: "일어날래 나랑살래?")
                .previewLayout(.sizeThatFits)
            RoomCell(isOnTime: false, title: "일어날래 나랑살래?")
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
