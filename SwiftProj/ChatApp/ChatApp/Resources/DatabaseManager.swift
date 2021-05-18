//
//  DatabaseManager.swift
//  ChatApp
//
//  Created by Drole on 18/05/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let  database = Database.database().reference()

}

// Account Management
extension DatabaseManager{
    
    public func userEmailExists(with email: String,
                                completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value, with: {snaphot in
            guard  snaphot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
// Insert new user to Database
    public func addUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName,
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
   // let profilePictureUrl: String
}
