//
//  SetProfileViewModel.swift
//  ZanyaFirst
//
//  Created by BAE on 2023/07/19.
//

import Foundation
import CloudKit

class SplashViewModel: ObservableObject {
    
    @Published var name: String = ""
    
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    var profile = Profile(UID: "", name: "",imageKey: "", record: nil)

    @Published var goToMainView: Bool = false
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
        
        fetchUID()
    }
    
    func fetchUID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                let predicate = NSPredicate(format: "uid = %@", argumentArray: ["\(id.recordName)"])
                let query = CKQuery(recordType: "Profile", predicate: predicate)
                let queryOperation = CKQueryOperation(query: query)
                
                queryOperation.recordMatchedBlock = {  (returnedRecordID, returnedResult) in
                    switch returnedResult {
                    case .success(let record):
                        guard let name = record["uid"] as? String else { return }
                        guard let imageKey = record["ImageKey"] as? String else { return }
                        print("user exist")
                        print(name)
                        
                        self?.profile.UID = name
                        self?.profile.imageKey = imageKey
                        self?.profile.record = record
                        
                        
                        
                        self?.haveProfile()
                    case .failure(let error):
                        print("Error recordMatchedBlock: \(error)")
                    }
                }// queryOperation.recordMatchedBlock
                
                queryOperation.queryResultBlock = { returnedResult in
                    print("Returned result splash1: \(returnedResult)")
                    DispatchQueue.main.async { }
                }// queryOperation.queryResultBlock
                //                print("queryOperation : \(queryOperation.query!)")
                // Profile이 있는지만 확인하기 위함으로, 아래 line은 불필요함.
                CKContainer.default().publicCloudDatabase.add(queryOperation)
            }// if let id = returnedID
        }
    }
    
    
    // MARK: - User의 iCloud계정 가져오기
    // 고유의 iCloud 계정이 데이터 베이스에 저장돼요.
    private func getiCloudStatus() {
        CKContainer.default().accountStatus{ [weak self] returnedStatus, returnedError in   //비동기 코드를 사용하고 있기 때문에 weak self 사용
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }// getiCloudStatus
    
    // 계정을 가져오지 못했을 경우의 에러메시지들
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    // iCloud계정에서 가저온 이름을 fetch하는 함수에요!
    func fetchiCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID{
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    // 사용자의 이름을 가져올 수 있도록 접근 권한을 물어보는 함수에요!
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted{
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    // iCloud계정에서 userName 가져오는 함수에요!
    func discoveriCloudUser(id: CKRecord.ID) {
        // UserID를 통해서 데이터 가져오기
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.userName = name
                }
                
                // 아래 코드를 통해서 이메일이나 전화번호등을 가져올 수도 있어요.
                //returnedIdentity?.lookupInfo?.emailAddress
            }
        }
    }
    
//    func nextButtonPressed() {
//        guard !name.isEmpty else { return }
//        //        addName(name: name)
//        haveProfile()
//    }
    
    func haveProfile() {
        DispatchQueue.main.async {
            self.goToMainView = true
        }
    }
    
    
}
