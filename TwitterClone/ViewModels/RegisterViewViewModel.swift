//
//  RegisterViewViewModel.swift
//  TwitterClone
//
//  Created by Miguel Quezada on 31-10-22.
//

import Combine
import Firebase
import Foundation

final class RegisterViewViewModel: ObservableObject {
    @Published var email: String?
    @Published var password: String?
    @Published var isRegistrationFormValid: Bool = false
    @Published var user: User?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func validateRegistrationForm(){
        guard let email = email,
              let password = password else {
            isRegistrationFormValid = false
            return }
        isRegistrationFormValid = isValidEmail(email: email) && password.count >= 8
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func createUser() {
        guard let email = email,
              let password = password else {
            return
        }
        AuthManager.shared.registerUser(with: email, password: password).sink { _ in
            
        } receiveValue: { [weak self] user in
            self?.user = user
        }
        .store(in: &subscriptions)

    }

}
