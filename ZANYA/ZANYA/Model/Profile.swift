//
//  Profile.swift
//  ZANYA
//
//  Created by 박승찬 on 2023/07/18.
//

import Foundation
import CloudKit

struct Profile: Hashable {
    let UID: String
    var name: String
    var imageKey: String?
    let record: CKRecord?
}
