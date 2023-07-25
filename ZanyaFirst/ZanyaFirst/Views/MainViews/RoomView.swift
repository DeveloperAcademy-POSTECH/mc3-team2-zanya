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
    @Environment(\.dismiss) private var dismiss

//    var profile: Profile
    let profileImageArray = ProfileImageArray
    
    
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
    }
}



////MARK: -3. PREVIEW
//struct RoomView_Preview: PreviewProvider {
//    static var previews: some View {
//        RoomView(viewModel: dummyRoomViewModels[0], path: .constant(NavigationPath()), profile: dummyProfile0)
//    }
//}

//MARK: - 4. EXTENSION
extension RoomView {
    
    private var backgroundPage: some View {
        ZStack(alignment: .topLeading){
            //배경화면
            Image(BackgroundSheet)
            //배경 서있는 고양이 이미지
//            Image(profile.imageKey ?? shamCat_Standing) // 이미지 키 받아오기
            Image(gentleCat_Standing) // 이미지 사이즈 확인을 위한 테스트용 이미지
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
        ZStack(alignment: .bottom){
            Image(PunchPage)
                .padding(.init(top: 0, leading: 0, bottom: -98, trailing: 0))
            punchElements
            Image(HandArray[0][ArrayNum])// TODO: - 클라우드에서 프로필 값 받아오기 / 일단 가라로 0 넣어둠
        }
    }
    
    private var punchElements: some View {
        let SoundList = [Sounds.catcat, Sounds.pigpig, Sounds.dogdog]
        let punchElementPage = [TambourinePage1, BBoongPage1, DJPage1]
        let Punchelement = [Tambourine, BBoong, DJ]
        
        return ZStack(alignment: .center) {
                TabView{
                    ForEach(0..<3, id: \.self ){ i in
                        ZStack(alignment: .center){
                            Image(punchElementPage[i])
                            HStack{
                                Image(InstrumentLeft)
                                    .padding(.init(top: 0, leading: 17.96, bottom: 0, trailing: 0))
                                Spacer()
                                Image(Punchelement[i])
                                    .onTapGesture {
                                        print("\(ArrayNum)")
                                        tapElement()
                                        playSound(sound: SoundList[i].rawValue)
                                    }
                                Spacer()
                                Image(InstrumentRight)
                                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 17.96))
                            }
                        }
                    }
                }.tabViewStyle(.page(indexDisplayMode: .never))
            
        }.frame(height: 360)
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

