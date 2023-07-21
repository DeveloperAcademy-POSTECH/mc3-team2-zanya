//
//  RoomBottomView.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/19.
//

import SwiftUI
import AVFoundation
import AVKit

struct RoomBottomView: View {
    //MARK: - 1. PROPERTY
    @Binding var PunchMessageToggle: Bool
    @State var ArrayNum : Int = 0
    @State var tapSize : CGFloat = 200
    @State var text: String = ""
    let utterance = AVSpeechUtterance()
    let synthesizer = AVSpeechSynthesizer()
    var profile : Profile
    
    //MARK: - 2. BODY
    var body: some View {
        
    ZStack{
            punchPage
            messagePage
        }
        

        .ignoresSafeArea()
        .frame(width: screenWidth, height: screenHeight / 2)
    }
}

//MARK: - 3. PREVIEW


//struct RoomBottomView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            RoomBottomView(PunchMessageToggle: .constant(false), profile: dummyProfile3)
//            RoomBottomView(PunchMessageToggle: .constant(true), profile: dummyProfile3)
//        }
//    }
//}

extension RoomBottomView {
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
            
//            Image(HandArray[profile.imageKey][ArrayNum])
//                .offset(y: 130)
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
        }.tabViewStyle(.page(indexDisplayMode: .always))
            .frame(width: screenWidth, height: screenWidth)
    }
    
    func tapElement() {
        if ArrayNum == 2 {
            ArrayNum = 0
        } else {
            ArrayNum += 1 }
    }
}
