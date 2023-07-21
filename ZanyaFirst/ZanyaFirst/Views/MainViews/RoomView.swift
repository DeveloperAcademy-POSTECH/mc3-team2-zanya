//
//  File.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import SwiftUI

import SwiftUI

struct RoomView: View {
    
    //MARK: - 1. PROPERTY

    @StateObject var viewModel: RoomViewModel
    @State var text : String = ""
    @State var ArrayNum : Int = 0
    @State var PunchMessageToggle: Bool = true
    @Binding var path: NavigationPath
    
    var profile: Profile
    let profileImageArray = ProfileImageArray
    
    
    //MARK: - 2. BODY
    var body: some View {
        ZStack {
            backgroundPage
            VStack{
                toolBar
                Spacer()
                memberSheet
                bottomTab
            }
            HiddenTapBurron
        }.navigationBarBackButtonHidden()
            .toolbar(.hidden)
    }
}



//MARK: -3. PREVIEW

//struct RoomView_Preview: PreviewProvider {
//    static var previews: some View {
//        RoomView(viewModel: dummyRoomViewModels[1], path: .constant(NavigationPath()), profile: dummyProfile0)
//    }
//}

//MARK: - 4. EXTENSION



extension RoomView {
    
    private var backgroundPage: some View {
        ZStack{
            Image(BackgroundSheet)
                .ignoresSafeArea()
            
//            Image(ProfileStandingArray[profile.imageKey ?? 0])
//                .offset(x:screenWidth/5.6, y: -screenHeight/6.5)
            
            if PunchMessageToggle == true {
                ZStack{
                    Image(PunchDialogSheet)
                    VStack{
                        //TODO: 시간모델 받아와야 함
                        TextCell(text: "99초" , size: 30, color: Color("FontRed"))
                        TextCell(text: "남았다냐:3\n", size: 14, color: Color("FontBlack"))
                    }
                }.offset(x: -screenWidth/4.9, y: -screenHeight/3.38)
            } else {
                ZStack{
                    Image(MessageDialogSheet)
                    TextCell(text: "도구에 냥냥펀치를 날리면 \n친구를 깨울 수 있자냐:3\n", size: 14, color: Color("FontBlack"))
                }.offset(x: -screenWidth/4.9, y: -screenHeight/3.38)
            }
        }
    }

    private var toolBar: some View {
        HStack{
            //BackButton
            Button {
                print("clicked back button")
                path.removeLast()
            } label: {
                Image(NavigationBackButton)
            }
            
            //RoomTitle
            ZStack{
                Image(RoomTitleSheet)
                Text(viewModel.roomInfo.name)
            }
            
            //QuestionButton
            Button {
                print("clicked question mark button")
            } label: {
                Image(QuestionButton)
            }
        }.padding(.top, 50)
    }
    
    private var memberSheet: some View {
        ZStack {
            Image(MemberSheet)
            HStack {
                ClearRectangle(width: 15,height: 20,ClearOn: true)
                ForEach(0..<viewModel.users.count) { i in
                    ZStack{
                        Image(ProfilePlate)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .padding(.top,12)
                            VStack{
//                                Image(profileImageArray[viewModel.users[i].imageKey ?? 0])
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 38)
                                TextCell(text: viewModel.users[i].name, size: 13, color: Color("FontBrown"))
                                    .padding(.top,-6)
                            }.padding(.top,17)
                    }
                }
                Spacer()
            }
        }
    }
    
    private var bottomTab: some View {
        ZStack {
            punchPage
                .zIndex(PunchMessageToggle ? 1 : 0)
            messagePage
                .zIndex(PunchMessageToggle ? 0 : 1)
        }
    }
    
    private var messagePage: some View {
        ZStack{
            Image(MessagePage)
            Image(Rectangle77)
                .padding(.bottom,-75)
            
            //            MessageListView()
            //                .offset(y:-17)
            
            Image(Rectangle33)
                .offset(y: 133)
            
            VStack{
                //TTS BUTTON
                HStack{
                    Button {
                        print("clickedTTS1")
                    } label: {
                        Image(TTS1ButtonImageActivate)
                    }
                    Button {
                        print("clickedTTS2")
                    } label: {
                        Image(TTS2ButtonImage)
                    }
                    Button {
                        print("clickedTTS3")
                    } label: {
                        Image(TTS3ButtonImage)
                    }
                    Button {
                        print("clickedTTS4")
                    } label: {
                        Image(TTS4ButtonImage)
                    }
                    Spacer()
                }.padding(.horizontal,15)
                HStack(spacing: 15){
                    ZStack{
                        Image(Rectangle11)
                        TextField("메세지를 입력하세요", text: $text)
                            .frame(width:280)
                    }
                    Button {
                        print("음성메세지 전송버튼") //TODO: 음성메세지 전송할 수 있게 하기
                    } label: {
                        if text != "" {
                            Image(SendButtonActivate)}
                        else {
                            Image(SendButtonDisabled)
                        }
                    }
                }
            }.offset(y: 120)
        }.ignoresSafeArea()
    }
    
    private var punchPage: some View {
        ZStack{
            Image(PunchPage)
            punchElements
                .padding(.bottom, -60)
            
//            Image(HandArray[profile.imageKey ?? 0][ArrayNum])
//                .offset(y: 130)
//                .offset(y: screenHeight/6)
        }
    }
    
    private var punchElements: some View {
        let SoundList = [Sounds.catcat, Sounds.pigpig, Sounds.dogdog]
        let punchElementPage = [TambourinePage1, BBoongPage1, DJPage1]
        let Punchelement = [Tambourine, BBoong, DJ]
        
        return TabView{
            ForEach(0..<3, id: \.self ){ i in
                ZStack{
                    Image(punchElementPage[i])
                    Image(Punchelement[i])
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.5)
                    
                    Button(action: {
                        print("\(ArrayNum)")
                        tapElement()
                        playSound(sound: SoundList[i].rawValue)
                    }, label: {
                        Circle()
                            .frame(width: screenWidth/2)
                            .foregroundColor(.clear)
                    })
                }
            }
        }.tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: screenWidth, height: screenWidth)
    }
    
    private var HiddenTapBurron: some View {
        
        HStack{
            Button {
                PunchMessageToggle = true
            } label: {
                Rectangle()
                    .frame(height: 50)
                
            }
            Button {
                PunchMessageToggle = false
            } label: {
                Rectangle()
                    .frame(height: 50)
                
            }
        } .offset(y: 40)
            .foregroundColor(.clear)
        
    }
    
    func tapElement() {
        if ArrayNum == 2 {
            ArrayNum = 0
        } else {
            ArrayNum += 1 }
    }
}

