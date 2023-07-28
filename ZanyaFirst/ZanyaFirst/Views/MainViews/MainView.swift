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
    var rooms : [RoomViewModel] = dummyRoomViewModels//TODO: 프리뷰 용임 //올리기 전에 지워야함
    
    
    //MARK: - 2. BODY
    var body: some View {
        NavigationView {
            ZStack{
                MainPageBackground
                MainPageProfileButton
                MainPageRoomList
                MainPageCreateRoomBtn
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        
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
struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(profile: dummyProfile4))
            .environmentObject(LocalNotificationManager())
    }
}

//MARK: -4. EXTENSION
extension MainView {
    private var MainPageBackground: some View {
        ZStack {
            Image(MainPageSheetImage)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image(RoomListImage)
                    .padding(.top, 51)
                Spacer()
            }
        }
    }
    
    private var MainPageProfileButton: some View {
        VStack{
            HStack{
                Spacer()
                //TODO: - 프로필 설정 페이지로 이동
                NavigationLink {
                    UpdateProfileView(viewModel: UpdateProfileViewModel(profile: viewModel.profile, delegate: viewModel))
                } label: {
                    Image(MainPageProfile)
                        .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
                    //                        .border(.red)
                }
                .padding(EdgeInsets(top: 43, leading: 0, bottom: 0, trailing: 18))
                //                .border(.orange)
            }
            Spacer()
        }
    }
    
    private var MainPageCreateRoomBtn: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                NavigationLink {
                    CreateRoomView()
                } label: {
                    ClearRectangle(width: 121, height: 34, ClearOn: true)
                    //    .border(.red)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 36.8, trailing: 10))
            }
        }
    }
    
    private var MainPageRoomList: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // if rooms.count == 0 {
                // Image(EmptyRoomSheetImage)
                //    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                // }
                ForEach(viewModel.rooms, id: \.self) { room in
                    NavigationLink{
                        RoomView(viewModel: RoomViewModel(allUsers: viewModel.allUsers, users: [viewModel.profile], roomInfo: room))
                    } label: {
                        RoomCell(title: room.name, userCount: room.UIDs.count)
                        
                    }// label
                }// ForEach
            }// ScrollView
            .refreshable {
                viewModel.fetchItem()
            }
            .scrollIndicators(.hidden)
            .padding(.top, 183)
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
