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
    let subscriptionID = "notification_add"
    
    init(allUsers: [Profile], users: [Profile], roomInfo: Room) {
        self.allUsers = allUsers
        self.users = users
        self.roomInfo = roomInfo
        
        requestNotificationPermission()
        subscribeToNotifications()
        
        fetchRoom()
        print("모든 유저 : \(allUsers.count)")
        print("방 유자: \(users.count)")
    }
    
    
    // MARK: - notification permission
    func requestNotificationPermission() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error.localizedDescription)
            } else if success {
                print("NOTIFICATION PERMISSION SUCCESS")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("NOTIFICATION PERMISSION FAILURE")
            }
        }
    }
    
    // MARK: - 알람구독
    func subscribeToNotifications() {
        let recordType = CKRecord(recordType: "AlarmDB")
        let predicate = NSPredicate(format: "roomRecord = %@", argumentArray: ["\(self.roomInfo.record?.description)"])
        let options: CKQuerySubscription.Options = [.firesOnRecordCreation]
        let subscription = CKQuerySubscription(recordType: recordType.recordType, predicate: predicate, subscriptionID: subscriptionID, options: options)
        let notification = CKSubscription.NotificationInfo()
        notification.title = "냥"
        notification.alertBody = "일어나라냥"
        notification.soundName = "default"
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
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: subscriptionID) { returnedID, returnedError in
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


}
