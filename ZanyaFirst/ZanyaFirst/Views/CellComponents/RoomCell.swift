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
                
                VStack{
                    HStack{
                        TextCell(text: title, size: 19, color: .black)
                        Spacer()
                        Button {
                            print("dd")
                            isClickedOut = true
                        } label: {
                            Image(RoomBoxOutPink)
                        }
                    }
                    .padding()
                    .frame(width: 300)
                    .confirmationDialog("방을 나가게 됩니다.", isPresented: $isClickedOut, titleVisibility: .visible){
                        Button("나가기",role: .destructive){
                            //TODO: 나가기 액션
                        }
                    }
                    HStack{
                        VStack(alignment: .leading){
                            TextCell(text: "오전", size: 15, color: .black) //TODO: -DATEMODEL로 바까야함
                            TextCell(text: "11:00", size: 40, color: .accentColor) //TODO: -DATEMODEL로 바까야함
                        }.padding(.horizontal)
                        Spacer()
                        VStack(alignment: .trailing){
                            Image(InviteTalkBox)
                            Button {
                                print("공유하기 작동") //TODO: -공유하기 기능 추가해야함
                            } label: {
                                ZStack(alignment: .center){
                                    Image(InvitePinkBtn)
                                    HStack{
                                        Image(InviteTextPink)
                                        TextCell(text: "0/6", size: 12, color: .accentColor)
                                            .foregroundColor(.white)
                                    }.padding(.bottom,7)
                                }
                            }
                        }.padding(.horizontal)
                    }.frame(width: 300)
                }
            }
        } else {
            //IsOnTime = false
            ZStack{
                Image(RoomCellSheetBlue)
                // width: 300, height: 159
                
                VStack{
                    HStack{
                        TextCell(text: title, size: 19, color: .accentColor)
                        Spacer()
                        Button {
                            print("ddd")
                            isClickedOut = true
                        } label: {
                            Image(RoomBoxOutBlue)
                        }
                    }
                    .padding()
                    .frame(width: 300)
                    .confirmationDialog("방을 나가게 됩니다.", isPresented: $isClickedOut, titleVisibility: .visible){
                        Button("나가기",role: .destructive){
                            //TODO: 나가기 액션
                        }
                    }
                    HStack{
                        VStack(alignment: .leading){
                            TextCell(text: "오전", size: 15,color: .accentColor) //TODO: -DATEMODEL로 바까야함
                            TextCell(text: "11:00", size: 40, color: .accentColor) //TODO: -DATEMODEL로 바까야함
                        }.padding(.horizontal)
                        Spacer()
                        VStack(alignment: .trailing){
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 110,height: 31) // InviteTalkBox랑 같은 사이즈 투명박스
                            Button {
                                print("공유하기 작동") //TODO: -공유하기 기능 추가해야함
                            } label: {
                                ZStack(alignment: .center){
                                    Image(InviteBlueBtn)
                                    HStack{
                                        Image(InviteTextBlue)
                                        TextCell(text: "0/6", size: 12, color: .accentColor)
                                            .foregroundColor(.white)
                                    }.padding(.bottom,2)
                                }
                            }
                        }.padding(.horizontal)
                    }.frame(width: 300)
                }
            }
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
