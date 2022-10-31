//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Miguel Quezada on 31-10-22.
//

import Combine
import Firebase
import FirebaseAuthCombineSwift
import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
