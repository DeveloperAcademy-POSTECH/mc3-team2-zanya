//
//  RoomCellViewModel.swift
//  ZanyaFirst
//
//  Created by BAE on 2023/07/30.
//

import Foundation

class RoomCellViewModel: ObservableObject {
    @Published var isOnTime: Bool
    @Published var title: String = ""
    @Published var userCount: Int = 0
    let preFix: String = "zanya-invite:://"
    @Published var room: Room
    
    var timeComponenets = DateComponents()
    
    init(isOnTime:Bool, room: Room){
        self.isOnTime = isOnTime
        self.title = room.name
        self.userCount = room.UIDs.count
        self.room = room
        self.timeComponenets = Calendar.current.dateComponents([.hour,.minute], from: room.time)
    }
}
