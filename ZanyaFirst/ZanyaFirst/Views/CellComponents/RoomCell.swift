//
//  RoomCell.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/19.
//

import SwiftUI

struct RoomCell: View {
    
    var isOnTime: Bool = true //TODO: -일단 트루놨는데 알람에서 타임 받아서 여기 비워줘야함
    @State var isClickedOut: Bool = false
    var title: String
    //var time: Date //TODO: 시간 모델 만들어서 받아야함
    
    var body: some View {
        
        if isOnTime == true {
            ZStack{
                Image(RoomCellSheetPink)
                // width: 300, height: 159
                VStack(spacing: 0){
                    HStack(alignment: .center,spacing: 0){
                        //Room Title
                        StrokedTextCellLeading(text: title, size: 19, strokeColor: AppWine)
                        
                        Spacer()
                        
                        //OutButton
                        Button {
                            print("dd")
                            isClickedOut = true
                        } label: {
                            Image(RoomBoxOutPink)
                        }
                    }.padding(.init(top: 21, leading: 15, bottom: 0, trailing: 18))
                        .frame(width: 300)
                        .confirmationDialog("방을 나가게 됩니다.", isPresented: $isClickedOut, titleVisibility: .visible){
                            Button("나가기",role: .destructive){
                                //TODO: 방나가기 액션
                            }
                        }
                    
                    HStack(spacing: 0){
                        //Time
                        VStack(alignment: .leading, spacing: 0){
                            //TODO: -DATEMODEL로 바까야함
                            TextCell(text: "오전", size: 14, color: Color(AppWine))
                                .padding(.init(top: -3, leading: -8, bottom: 5, trailing: 0))
                            
                            HStack {
                                //TODO: -DATEMODEL로 바까야함
                                StrokedTimeCell(text: "11:00", size: 40, color: Color(AppWine), strokeColor: AppWhite)
                                    .padding(.init(top: -4, leading: -47, bottom: -3, trailing: 0))
                                Spacer()
                            }
                        }
                        .padding(.init(top: 25, leading: 24, bottom: 0, trailing: 0))
                        
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            
                            Spacer()
                            
                            //친구를 초대해보세요
                            Image(InviteTalkBox)
                                .padding(.init(top: 0, leading: 0, bottom: -8, trailing: 16))
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
                            //InviteButton
                            ZStack{
                                Button {
                                    print("공유하기 작동") //TODO: -공유하기 기능 추가해야함
                                } label: {
                                    ZStack(alignment: .center){
                                        Image(InvitePinkBtn)
                                        HStack{
                                            Image(InviteTextPink)
                                            TextCell(text: "0/6", size: 12, color: .white,weight: "Regular")
                                                .foregroundColor(.white)
                                                .padding(.leading, -5)
                                        }.frame(width: 82)
                                    }
                                }
                            } .padding(.init(top: 0, leading: 0, bottom: 28, trailing: 16))
                        }
                    }.frame(width: 300)
                }
                
            }
            .frame(width: 304, height: 160)
        } else {
            //IsOnTime = false
            ZStack{
                Image(RoomCellSheetBlue)
                // width: 300, height: 159
                VStack(spacing: 0){
                    HStack(alignment: .center,spacing: 0){
                        //Room Title
                        StrokedTextCellLeading(text: title, size: 19, color: Color(AppLavender), strokeColor: Apppurple)
                        
                        Spacer()
                        
                        //OutButton
                        Button {
                            print("dd")
                            isClickedOut = true
                        } label: {
                            Image(RoomBoxOutBlue)
                        }
                    }.padding(.init(top: 21, leading: 15, bottom: 0, trailing: 18))
                        .frame(width: 300)
                        .confirmationDialog("방을 나가게 됩니다.", isPresented: $isClickedOut, titleVisibility: .visible){
                            Button("나가기",role: .destructive){
                                //TODO: 방나가기 액션
                            }
                        }
                    
                    HStack(spacing: 0){
                        //Time
                        VStack(alignment: .leading, spacing: 0){
                            //TODO: -DATEMODEL로 바까야함
                            TextCell(text: "오전", size: 14, color: Color(Apppurple))
                                .padding(.init(top: -3, leading: -8, bottom: 5, trailing: 0))
                            
                            HStack {
                                //TODO: -DATEMODEL로 바까야함
                                StrokedTimeCell(text: "11:00", size: 40, color: Color(Apppurple), strokeColor: AppWhite)
                                    .padding(.init(top: -4, leading: -47, bottom: -3, trailing: 0))
                                
                                Spacer()
                                
                            }
                        }
                        .padding(.init(top: 25, leading: 24, bottom: 0, trailing: 0))
                        
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Spacer()
                            ClearRectangle(width: 130, height: 40,ClearOn: true)
                            //InviteButton
                            ZStack{
                                Button {
                                    print("공유하기 작동") //TODO: -공유하기 기능 추가해야함
                                } label: {
                                    ZStack(alignment: .center){
                                        Image(InviteBlueBtn)
                                        HStack{
                                            Image(InviteTextBlue)
                                            TextCell(text: "0/6", size: 12, color: .white,weight: "Regular")
                                                .foregroundColor(.white)
                                                .padding(.leading, -5)
                                        }.frame(width: 82)
                                    }
                                }
                            } .padding(.init(top: 0, leading: 0, bottom: 28, trailing: 16))
                        }
                    }.frame(width: 300)
                }
            }.frame(width: 304, height: 160)
        }
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
