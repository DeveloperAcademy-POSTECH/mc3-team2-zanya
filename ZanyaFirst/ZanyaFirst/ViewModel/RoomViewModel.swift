//
//  File.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import Foundation
import CloudKit
import UserNotifications
import UIKit

class RoomViewModel: ObservableObject {
    
    @Published var allUsers: [Profile]
    @Published var users: [Profile]
    @Published var roomInfo: Room
    
    //구독 아이디
    let subscriptionID_Cat = "notification_Cat"
    let subscriptionID_Dog = "notification_Dog"
    let subscriptionID_Pig = "notification_Pig"
    
    
    init(allUsers: [Profile], users: [Profile], roomInfo: Room) {
        self.allUsers = allUsers
        self.users = users
        self.roomInfo = roomInfo
        
//        requestNotificationPermission()
//        subscribeToNotifications()

        fetchRoom()
        fetchUsers()
        
        print("모든 유저 수 : \(allUsers.count)")
        print("방 인원: \(users.count)")
    }
    
    func fetchUsers() {
        for user in roomInfo.UIDs{
            for prof in allUsers {
                if user == prof.UID{
                    if !users.contains(prof) {
                        users.append(prof)
                    }
                }
            }
        }
    }
    
    
    // MARK: - notification permission
    func requestNotificationPermission() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge, .criticalAlert]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error.localizedDescription)
            } else if success {
                print("NOTIFICATION PERMISSION SUCCESS")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    print("permission됨")
                }
            } else {
                print("NOTIFICATION PERMISSION FAILURE")
            }
        }
    }
    
    // MARK: - 알람구독
    func subscribeToNotifications_Cat() {
        let recordType = CKRecord(recordType: "AlarmNyang")
        let predicate = NSPredicate(format: "roomRecord = %@", argumentArray: ["\(self.roomInfo.record?.recordID.recordName ?? "")"])
        print("@log - RoomViewModel: room's record -> \(self.roomInfo.record?.recordID.recordName ?? "")")
        //let predicate = NSPredicate(value: true)
        let options: CKQuerySubscription.Options = [.firesOnRecordCreation]
        let subscription = CKQuerySubscription(recordType: recordType.recordType, predicate: predicate, subscriptionID: subscriptionID_Cat, options: options)
        let notification = CKSubscription.NotificationInfo()
        notification.title = "\(self.roomInfo.name)"
        notification.alertBody = "일어나라 냥!"
        notification.soundName = "catcat.mp3"
        subscription.notificationInfo = notification
        CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let returnedError = returnedError {
                print(returnedError.localizedDescription)
            } else {
                print("SUCCESSFULLY SUBSCRIBE NOTIFICATION")
            }
        }
    }
    
    func subscribeToNotifications_Dog() {
        let recordType = CKRecord(recordType: "AlarmDog")
        let predicate = NSPredicate(format: "roomRecord = %@", argumentArray: ["\(self.roomInfo.record?.recordID.recordName ?? "")"])
        print("@log - RoomViewModel: room's record -> \(self.roomInfo.record?.recordID.recordName ?? "")")
        //let predicate = NSPredicate(value: true)
        let options: CKQuerySubscription.Options = [.firesOnRecordCreation]
        let subscription = CKQuerySubscription(recordType: recordType.recordType, predicate: predicate, subscriptionID: subscriptionID_Dog, options: options)
        let notification = CKSubscription.NotificationInfo()
        notification.title = "\(self.roomInfo.name)"
        notification.alertBody = "일어나라 왈!"
        notification.soundName = "dogdog.mp3"
        subscription.notificationInfo = notification
        CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let returnedError = returnedError {
                print(returnedError.localizedDescription)
            } else {
                print("SUCCESSFULLY SUBSCRIBE NOTIFICATION")
            }
        }
    }
    func subscribeToNotifications_Pig() {
        let recordType = CKRecord(recordType: "AlarmPig")
        let predicate = NSPredicate(format: "roomRecord = %@", argumentArray: ["\(self.roomInfo.record?.recordID.recordName ?? "")"])
        print("@log - RoomViewModel: room's record -> \(self.roomInfo.record?.recordID.recordName ?? "")")
        //let predicate = NSPredicate(value: true)
        let options: CKQuerySubscription.Options = [.firesOnRecordCreation]
        let subscription = CKQuerySubscription(recordType: recordType.recordType, predicate: predicate, subscriptionID: subscriptionID_Pig, options: options)
        let notification = CKSubscription.NotificationInfo()
        notification.title = "\(self.roomInfo.name)"
        notification.alertBody = "일어나라 꿀!"
        notification.soundName = "pigpig.mp3"
        subscription.notificationInfo = notification
        CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let returnedError = returnedError {
                print(returnedError.localizedDescription)
            } else {
                print("SUCCESSFULLY SUBSCRIBE NOTIFICATION")
            }
        }
    }
    
    // MARK: - 알람 구독 취소(임시 추가)
    func unsubscribeToNotification() {
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: subscriptionID_Dog) { returnedID, returnedError in
            if let returnedError = returnedError {
                print(returnedError.localizedDescription)
            } else {
                print("SUCCESSFULLY UNSUBSCRIBE NOTIFICATION")
            }
        }
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: subscriptionID_Pig) { returnedID, returnedError in
            if let returnedError = returnedError {
                print(returnedError.localizedDescription)
            } else {
                print("SUCCESSFULLY UNSUBSCRIBE NOTIFICATION")
            }
        }
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: subscriptionID_Cat) { returnedID, returnedError in
            if let returnedError = returnedError {
                print(returnedError.localizedDescription)
            } else {
                print("SUCCESSFULLY UNSUBSCRIBE NOTIFICATION")
            }
        }
    }
    
    
    func fetchRoom() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                let predicate = NSPredicate(format: "name = %@", argumentArray: ["\(self?.roomInfo.name)"])
                let query = CKQuery(recordType: "Room", predicate: predicate)
                let queryOperation = CKQueryOperation(query: query)
                
                queryOperation.recordMatchedBlock = {  (returnedRecordID, returnedResult) in
                    switch returnedResult {
                    case .success(let record):
                        guard let uids = record["uids"] as? [String] else { return }
                        DispatchQueue.main.async {
                            for uid in uids{
                                if let all = self?.allUsers {
                                    for user in all {
                                        if user.UID == uid {
                                            self?.users.append(Profile(UID: uid, name: user.name,imageKey: user.imageKey, record: user.record))
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                    case .failure(let error):
                        print("Error recordMatchedBlock: \(error)")
                    }
                }
                
                queryOperation.queryResultBlock = { returnedResult in
                    print("Returned result: \(returnedResult)")
                    
                    
                }
                
                CKContainer.default().publicCloudDatabase.add(queryOperation)
            }
        }
        
    }
    
    private func sendPig(name: String) {
        let alarm = CKRecord(recordType: "AlarmPig")
        
        alarm["whoSend"] = name
        alarm["roomRecord"] = self.roomInfo.record?.recordID.recordName
        
        self.saveItem(record: alarm)
    }
    
    private func sendDog(name: String) {
        let alarm = CKRecord(recordType: "AlarmDog")
        
        alarm["whoSend"] = name
        alarm["roomRecord"] = self.roomInfo.record?.recordID.recordName
        
        self.saveItem(record: alarm)
    }
    
    
    private func sendNyang(name: String) {
        let alarm = CKRecord(recordType: "AlarmNyang")
        
        alarm["whoSend"] = name
        alarm["roomRecord"] = self.roomInfo.record?.recordID.recordName
        
        self.saveItem(record: alarm)
    }

    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            
            DispatchQueue.main.async {
                print("RoomViewModel: 알람보내기!")
            }
        }
    }
    
    func touchNyang() {
        sendNyang(name: self.users[0].name)
        print("RoomViewModel: 터치하기냥")
    }
    
    func touchDog() {
        sendDog(name: self.users[0].name)
        print("RoomViewModel: 터치하기왈")
    }
    
    func touchPig() {
        sendPig(name: self.users[0].name)
        print("RoomViewModel: 터치하기꿀")
    }
}
