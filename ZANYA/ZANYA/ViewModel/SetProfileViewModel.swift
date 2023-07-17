//
//  SetProfileViewModel.swift
//  ZANYA
//
//  Created by 박승찬 on 2023/07/18.
//

import Foundation

import CloudKit
class SetProfileViewModel: ObservableObject {
    
    var profile: Profile = Profile(UID: "", name: "", imageKey: nil, record: nil)
    
    @Published var catName: String = ""
    @Published var userName: String = ""
    
    init() {
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
                        guard let name = record["name"] as? String else { return }
                        
                        DispatchQueue.main.async {
                            self?.profile = Profile(UID: id.recordName, name: name, imageKey: nil, record: record)
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
    
    // MARK: - Update
    private func updateItem(profile: Profile) {
        fetchUID()
        self.profile.imageKey = catName
        self.profile.name = userName
        if let record = profile.record{
            record["UserName"] = userName
            record["ImageKey"] = catName
            saveItem(record: record)
            //print("업데이트")
        }
    }

    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
        }
    }
    
    func completeButtonPressed() {
        guard !catName.isEmpty else { return }
        guard !userName.isEmpty else { return }
        
        updateItem(profile: profile)
        
    }
    
    func clickedCatBtn(_ cat: String) {
        catName = cat
    }
    
}
