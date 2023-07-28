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
        RoomView(viewModel: dummyRoomViewModels[0] )
    }
}

//MARK: - 4. EXTENSION
extension RoomView {
    
    private var backgroundPage: some View {
        ZStack(alignment: .topLeading){
            //배경화면
            Image(BackgroundSheet)
            //배경 서있는 고양이 이미지
//            Image(profile.imageKey ?? shamCat_Standing) // 이미지 키 받아오기
            Image("\(viewModel.users[0].imageKey ?? "")_Standing") // 이미지 사이즈 확인을 위한 테스트용 이미지
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
                            Image("\(viewModel.users[i].imageKey ?? "")_RoomSheet") // TODO: 룸데이터에서 유저 정보 받아와야함
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
    
    private var messagePage: some View {
        ZStack(alignment: .bottom){
            Image(MessagePage)
                .padding(.init(top: 0, leading: 0, bottom: -98, trailing: 0))
            Image(Rectangle77)
            Image(Rectangle33)
            
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
//    private var punchPage: some View {
//        let SoundList = [Sounds.catcat, Sounds.pigpig, Sounds.dogdog]
//        let punchElementPage = [TambourinePage, BBoongPage, DJPage]
//        let punchElementPage2 = [TambourinePage2, BBoongPage2, DJPage2]
//        let Punchelement = [Tambourine, BBoong, DJ]
//
//
//
//        return ZStack(alignment: .bottom){
//            Image(PunchPage)
//                .padding(.init(top: 0, leading: 0, bottom: -98, trailing: 0))
//            ZStack(alignment: .center) {
//                TabView{
//                    ForEach(0..<3, id: \.self ){ i in
//                        ZStack(alignment: .center){
//                            Image(punchElementPage2[i])
//                                .zIndex(isItemEffect ? 2 : 0)
//                            Image(punchElementPage[i])
//                                .zIndex(1)
//                            HStack{
//                                Spacer()
//                                Image(Punchelement[i])
//                                    .scaleEffect(isItemEffect ? 1.1 : 1.0)
//                                    .rotationEffect(isItemEffect ? .degrees(changingDerees) : .zero)
//
//                                    .onTapGesture {
//                                        print("Tap ZStack")
//                                 //       EffectSound.shared.playEffectSound()    // 효과음 내는 곳
//                                        playSound(sound: SoundList[i].rawValue)
//                                        withAnimation {
//                                            isItemEffect.toggle()   // 배경 물방울이랑 템버린 반응용 bool
//                                        }
//                                        touchCount += 1 // 고양이 왼손 오른손을 교차하기 위한 로직
//                                        switch touchCount % 2 {
//                                        case 0:
//                                            catHandIndex = 2
//                                        case 1:
//                                            catHandIndex = 1
//                                        default:
//                                            break
//                                        }
//                                        if isItemEffect {
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                                catHandIndex = 0
//                                                withAnimation {
//                                                    isItemEffect = false
//                                                    changingDerees *= -1
//                                                }
//                                            }
//                                        }
//                                    }
//                                Spacer()
//                            }.zIndex(3)
//                        }
//                    }
//                }.tabViewStyle(.page(indexDisplayMode: .never))
//
//                HStack(spacing: 0){
//                    Image(InstrumentLeft)
//                        .padding(.init(top: 0, leading: 3, bottom: 0, trailing: 0))
//                        .onTapGesture {
//
//                        }
//                    Spacer()
//                    Image(InstrumentRight)
//                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 3))
//                }.padding(.bottom, 37)
//            }.frame(width: 360, height: 360)
//            Image(HandArray[0][catHandIndex])// TODO: - 클라우드에서 프로필 값 받아오기 / 일단 가라로 0 넣어둠
//        }
//    }
    
    
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

