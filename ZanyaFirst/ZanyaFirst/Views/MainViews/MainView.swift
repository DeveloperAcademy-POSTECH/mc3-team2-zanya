//
//  MainView.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import SwiftUI

struct MainView: View {
    
    //MARK: -1. PROPERTY
    //권한설정 요구하는 거임
    @EnvironmentObject var lnManager: LocalNotificationManager
    
    @StateObject var viewModel: MainViewModel
    @StateObject var roomViewModel: RoomViewModel
    @Environment(\.scenePhase) var scenePhase
    
    @State private var isCreateButtonClicked : Bool = false
    @State private var path = NavigationPath()
    @State private var profileNumber: Int = 0
    
    @State var ShowOnBoarding: Bool = true
    
    let profileArray = ProfileImageArray
    //MARK: 프리뷰하려고 더미룸 데이터 넣고 뿌림
    var rooms : [RoomViewModel]
    
    
    //MARK: - 2. BODY
    var body: some View {
        
        NavigationStack(path: $path) {
            ZStack{
                MainPageBackground
                MainPageProfileButton
                MainPageRoomList
                MainPageCreateRoomBtn
            }.ignoresSafeArea()
        }
        
        //TODO: 스플래시뷰 사용하려면 이거 열어야 함!// 바디밑에 붙이는 뷰임// 프리뷰때매 닫아둠!
        //        .fullScreenCover(isPresented: $ShowOnBoarding) {
        //            SplashViewMain(ShowOnBoarding: $ShowOnBoarding)
        //        }
        
        .task {
            try? await lnManager
                .requestAuthorization()
        }// task
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                Task {
                    await lnManager
                        .getCurrentSetting()
                    await lnManager
                        .getCurrentSetting()
                }
            }
        }// onChange
    }// body
}// MainView


//MARK: -3. PREVIEW
//struct MainView_Preview: PreviewProvider {
//    static var previews: some View {
//        MainView(viewModel: MainViewModel(profile: dummyProfile0), roomViewModel: dummyRoomViewModels[1])
//            .environmentObject(LocalNotificationManager())
//    }
//}

//MARK: -4. EXTENSION
extension MainView {
    private var MainPageBackground: some View {
        ZStack {
            Image(MainPageSheetImage)
                .ignoresSafeArea()
            VStack{
                Image(RoomListImage)
                    .padding(.top, 51)
                Spacer()
            }
        }// ZStack
    }
    
    private var MainPageProfileButton: some View {
        VStack{
            HStack{
                Spacer()
                //TODO: - 프로필 설정 페이지로 이동
                NavigationLink(value: "1") {
                    Image(MainPageProfileBinu)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 4)
                }
                .navigationDestination(for: String.self) {_ in
                    SetProfileView()
                }.padding(.init(top: 43, leading: 0, bottom: 0, trailing: 18))
                
            }
            Spacer()
        }
    }
    private var MainPageCreateRoomBtn: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(value: 2.0) {
                    ClearRectangle(width: 110, height: 40, ClearOn: true)
                        .padding(.init(top: 0, leading: 0, bottom: 40, trailing: 15))
                }
                .navigationDestination(for: Double.self) {ii in
                    CreateRoomView(path: $path)
                }
            }
        }
    }
    private var MainPageRoomList: some View {
        
        VStack{
            if rooms.count == 0 {
                //
                Image(EmptyRoomSheetImage)
                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            } else {
                ScrollView{
                    ForEach(0..<rooms.count, id: \.self) { i in
                        NavigationLink(value: i) {
                            RoomCell(title: rooms[i].roomInfo.name)
                                .padding(.init(top: 0, leading: 0, bottom: 2, trailing: 0))
                        }.navigationDestination(for: Int.self) { roomNum in
                            //TODO: - ROOMVIEW로 가야함
                            RoomView(viewModel: dummyRoomViewModels[roomNum], path: $path, profile: viewModel.profile)
                        }
                    }
                }.padding(.init(top: 177, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

extension Date {
    var displayFormat: String {
        self.formatted(
            .dateTime
                .hour(.twoDigits(amPM: .omitted))
                .minute(.twoDigits)
        )
    }
}
