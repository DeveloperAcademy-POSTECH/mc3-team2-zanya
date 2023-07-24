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
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var isCreateButtonClicked : Bool = false
    @State private var path = NavigationPath()
    @State private var profileNumber: Int = 0
    
    @State var ShowOnBoarding: Bool = true
    
    let profileArray = ProfileImageArray
    //MARK: 프리뷰하려고 더미룸 데이터 넣고 뿌림
    //    var rooms : [RoomViewModel] = dummyRoomViewModels
    
    
    //MARK: - 2. BODY
    var body: some View {
        
        NavigationStack(path: $path) {
            ZStack{
                MainPageBackground
                MainPageProfileButton
//                MainPageRoomList
                MainPageCreateRoomBtn
            }
        }.navigationBarBackButtonHidden(true)
        
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
                    .padding(.top, 50)
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
                }
                .navigationDestination(for: String.self) {_ in
                    SetProfileView()
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 40)
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
                        .padding(.horizontal)
                        .padding(.bottom,40)
                }
                .navigationDestination(for: Double.self) {ii in
                    CreateRoomView(path: $path)
                }
            }
        }
    }
    //    private var MainPageRoomList: some View {
    //        VStack{
    //            ClearRectangle(width: 2, height: screenHeight/5, ClearOn: true)
    //            ScrollView{
    //                ForEach(0..<rooms.count, id: \.self) { i in
    //                    NavigationLink(value: i) {
    //                        RoomCell(title: rooms[i].roomInfo.name)
    //                    }
    //                    .navigationDestination(for: Int.self) { roomNum in
    //                        //TODO: - ROOMVIEW로 가야함
    //                        RoomView(viewModel: dummyRoomViewModels[roomNum], path: $path, profile: viewModel.profile)
    //                    }
    //                }
    //            }
    //        }
    //    }
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
