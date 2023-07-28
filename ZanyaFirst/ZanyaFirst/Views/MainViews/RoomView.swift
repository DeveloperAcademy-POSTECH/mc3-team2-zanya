//
//  File.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import SwiftUI

struct RoomView: View {
    
    //MARK: - 1. PROPERTY
    @StateObject var viewModel: RoomViewModel
    @State var text : String = ""
    @State var ArrayNum : Int = 0
    @State var PunchMessageToggle: Bool = true
    @State var tapIndexNum : Int = 0
    @Environment(\.dismiss) private var dismiss

//    var profile: Profile
    let profileImageArray = ProfileImageArray
    
    //For DonAnimation
    @State private var changingDerees: Double = -10
    @State private var isItemEffect = false
    @State private var catHandIndex = 0
    @State private var touchCount = 0
    
    //MARK: - 2. BODY
    var body: some View {
        ZStack {
            backgroundPage
            VStack(spacing: 0){
                toolBar
                Spacer()
                memberSheet
                bottomTab
            
            }
            HiddenTapButton
        }.navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .toolbar(.hidden)
            .onAppear{
                viewModel.requestNotificationPermission()
                viewModel.subscribeToNotifications_Dog()
                viewModel.subscribeToNotifications_Cat()
                viewModel.subscribeToNotifications_Pig()
            }
    }
}



//MARK: -3. PREVIEW
struct RoomView_Preview: PreviewProvider {
    static var previews: some View {
        RoomView(viewModel: dummyRoomViewModels[1] )
    }
}

//MARK: - 4. EXTENSION
extension RoomView {
    
    private var backgroundPage: some View {
        ZStack(alignment: .topLeading){
            //배경화면
            Image(BackgroundSheet)
            //배경 서있는 고양이 이미지
            
            Image("\(viewModel.users[0].imageKey)_Standing" ?? "gentleCat_Standing")
                .resizable()
                .scaledToFit()
                .frame(width: 210)
                .padding(.init(top: 147, leading: 156.84, bottom: 0, trailing: 0))
            //펀치페이지 말풍성
            if PunchMessageToggle == true {
                ZStack(alignment: .topLeading){
                    Image(PunchDialogSheet)
                        .shadow(color: .black.opacity(0.2), radius: 3.18533, x: 0, y: 4.24711)
                    VStack(spacing: 5){
                        //TODO: 시간모델 받아와야 함
                        TextCell(text: "99초" , size: 30, color: Color("AppRed"))//TODO: 시간모델 받아와야 함
                            .padding(.top,-4.5)
                        Image(itsempty).padding(.top,-6)
                    } .padding(.init(top: 41.04, leading: 62, bottom: 0, trailing: 0))
                }.padding(.init(top: 104.96, leading: 13, bottom: 0, trailing: 0))
                //메세지 페이지 말풍선
            } else {
                ZStack{
                    Image(MessageDialogSheet)
                        .shadow(color: .black.opacity(0.2), radius: 3.18533, x: 0, y: 4.24711)
                }.padding(.init(top: 112, leading: 13, bottom: 0, trailing: 0))
            }
        }
    }

    private var toolBar: some View {
        HStack(spacing: 0){
            //BackButton
            Button {
                print("clicked back button")
                dismiss()
            } label: {
                Image(NavigationBackButton)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
            }
            
            //RoomTitle
            ZStack{
                Image(RoomTitleSheet)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
                StrokedTextCellCenter(text: viewModel.roomInfo.name, size: 18, color: .white, strokeColor: AppNavy)
                    .padding(.bottom, 4)
            }.padding(.init(top: 0, leading: 13, bottom: 0, trailing: 13))
            
            //QuestionButton
            Button {
                print("clicked question mark button")
            } label: {
                Image(QuestionButton)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
            }
        }
        .padding(.init(top: 53, leading: 15, bottom: 0, trailing: 15))
        .frame(maxWidth: screenWidth)
    }
    
    private var memberSheet: some View {
        ZStack(alignment: .bottomLeading) {
            Image(MemberSheet)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            
            HStack(alignment: .center,spacing: 0) {
                ForEach(0..<viewModel.users.count) { i in
                    ZStack(alignment: .center){
                        Image(ProfilePlateOff)
                        VStack {
                            //Spacer()
                            Image(profileImageArray[i]) // TODO: 룸데이터에서 유저 정보 받아와야함
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48)
                           // Spacer()
                            ClearRectangle(width: 0,height: 6)
                        }
                        VStack{
                            Spacer()
                            Image(nameSheet)
                        }
                        VStack{
                            Spacer()
                            TextCell(text: viewModel.users[i].name, size: 11, color: Color("AppBrown"))
                                .padding(.bottom, 4)
                        }
                    }.frame(width: 48, height: 60)
                        .padding(.init(top: 0, leading: 11, bottom: -16.75, trailing: 0))

                }
                Spacer()
            } .frame(width: 360, height: 111.5)
        }.padding(.init(top: 0, leading: 0, bottom: 13, trailing: 0))
    }
    
    private var bottomTab: some View {
        ZStack {
            punchPage
                .zIndex(PunchMessageToggle ? 1 : 0)
            messagePage
                .zIndex(PunchMessageToggle ? 0 : 1)
        }
    }
    
    private var punchPage: some View {
        let SoundList = [Sounds.catcat, Sounds.pigpig, Sounds.dogdog]
        let punchElementPage = [TambourinePage, BBoongPage, DJPage]
        let punchElementPage2 = [TambourinePage2, BBoongPage2, DJPage2]
        let Punchelement = [Tambourine, BBoong, DJ]
        
        return ZStack(alignment: .bottom){
            Image(PunchPage)
                .padding(.init(top: 0, leading: 0, bottom: -98, trailing: 0))
            ZStack(alignment: .center) {
                TabView{
                        ZStack(alignment: .center){
                            Image(punchElementPage2[tapIndexNum])
                                .zIndex(isItemEffect ? 2 : 0)
                            Image(punchElementPage[tapIndexNum])
                                .zIndex(1)
                            HStack{
                                Spacer()
                                Image(Punchelement[tapIndexNum])
                                    .scaleEffect(isItemEffect ? 1.1 : 1.0)
                                    .rotationEffect(isItemEffect ? .degrees(changingDerees) : .zero)
                                    .onTapGesture {
                                        print("Tap ZStack")
                                        print("\(tapIndexNum)")
                                 //       EffectSound.shared.playEffectSound()    // 효과음 내는 곳
                                        playSound(sound: SoundList[tapIndexNum].rawValue)
                                        withAnimation {
                                            isItemEffect.toggle()   // 배경 물방울이랑 템버린 반응용 bool
                                        }
                                        touchCount += 1 // 고양이 왼손 오른손을 교차하기 위한 로직
                                        switch touchCount % 2 {
                                        case 0:
                                            catHandIndex = 2
                                        case 1:
                                            catHandIndex = 1
                                        default:
                                            break
                                        }
                                        if isItemEffect {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                catHandIndex = 0
                                                withAnimation {
                                                    isItemEffect = false
                                                    changingDerees *= -1
                                                }
                                            }
                                        }
                                        switch tapIndexNum {
                                        case 0 :
                                            viewModel.touchNyang()
                                        case 1:
                                            viewModel.touchPig()
                                        case 2:
                                            viewModel.touchDog()
                                        default:
                                            viewModel.touchNyang()
                                        }
                                    }
                                Spacer()
                            }.zIndex(3)
                        }
                }.tabViewStyle(.page(indexDisplayMode: .never))
                
                HStack(spacing: 0){
                    Button {
                        if tapIndexNum == 0 {
                            tapIndexNum = 2}
                        else {
                            tapIndexNum -= 1
                        }
                        
                        print("\(tapIndexNum)")
                    } label: {
                        Image(InstrumentLeft)
                            .padding(.init(top: 0, leading: 3, bottom: 0, trailing: 0))
                    }
                    Spacer()
                    Button {
                        if tapIndexNum == 2 {
                            tapIndexNum = 0}
                        else {
                            tapIndexNum += 1
                        }
                        print("\(tapIndexNum)")
                    } label: {
                        Image(InstrumentRight)
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 3))
                    }
                }.padding(.bottom, 37)
            }.frame(width: 360, height: 360)
            Image(HandArray[0][catHandIndex])// TODO: - 클라우드에서 프로필 값 받아오기 / 일단 가라로 0 넣어둠
                
        }
    }

    private var messagePage: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: -12),
            count: 3
        )
        return ZStack(alignment: .bottom){
            Image(MessagePage)
                .padding(.init(top: 0, leading: 0, bottom: -98, trailing: 0))
            Image(Rectangle77)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(0..<10) {i in //TODO: - 메세지 데이터에서 메세지 숫자 받기
                        
                        Button {
                            print("message play")
                        } label: {
                            ZStack(alignment: .bottomLeading){
                                Image(messageCell)
                                    .resizable()
                                    .frame(width: 105, height: 85)
                                HStack {
                                    VStack(alignment: .leading){
                                        TextCell(text: "비누", size: 11, color: .white) // TODO: - 메세지 데이터에서 닉네임 받기
                                            .padding(.init(top: 0, leading: 10, bottom: -7, trailing: 0))
                                        TextCell(text: "20초", size: 10, color: .white) // TODO: - 메세지 데이터에서 시간 값 받기
                                            .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 0))
                                    }
                                    Spacer()
                                    Image("messageBox_WhiteCat") // TODO: - 메세지 데이터에서 프로필 이미지키 받기
                                        .resizable()
                                        .frame(width: 38.36, height: 31.54)
                                        .padding(.init(top: 0, leading: 0, bottom: 8.46, trailing: 9.64))
                                }
                            }.frame(width: 101, height: 81)
                        }
                    }
                }.padding(.top, 12)
            }.frame(width: 362, height: 226)
                .padding(.init(top: 0, leading: 0, bottom: 136, trailing: 0))
            Image(Rectangle33)
            
            
            
            VStack(spacing: 0){
                //TTS BUTTON
                HStack(spacing: 0){
                    Button {
                        print("clickedTTS1")
                    } label: {
                        Image(TTS1ButtonImageActivate)
                    }.padding(.trailing, 4)
                    Button {
                        print("clickedTTS2")
                    } label: {
                        Image(TTS2ButtonImage)
                    }.padding(.trailing, 4)
                    Button {
                        print("clickedTTS3")
                    } label: {
                        Image(TTS3ButtonImage)
                    }.padding(.trailing, 4)
                    Button {
                        print("clickedTTS4")
                    } label: {
                        Image(TTS4ButtonImage)
                    }.padding(.trailing, 4)
                    Spacer()
                }.padding(.init(top: 0, leading: 15, bottom: 16, trailing: 15))
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
            }
            .padding(.init(top: 0, leading: 0, bottom: 29, trailing: 0))
            
            
        }
            
        
    }
    
    private var HiddenTapButton: some View {
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
        }   .offset(y: 20)
            .foregroundColor(.clear)
            .padding(0)
    }
    
    func tapElement() {
        if ArrayNum == 2 {
            ArrayNum = 0
        } else {
            ArrayNum += 1 }
    }
    
}

