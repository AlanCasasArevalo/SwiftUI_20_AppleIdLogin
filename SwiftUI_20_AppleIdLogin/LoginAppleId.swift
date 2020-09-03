import Foundation
import AuthenticationServices

class LoginAppleId: NSObject, ASAuthorizationControllerDelegate {
    func getAppleRequest () {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.delegate = self
        authController.performRequests()
    }
    
    func getUserInfo(fullName: String, email: String) {
        let user = UserModel(name: fullName, email: email)
        if let userEncoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(userEncoded, forKey: "userEncoded")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        guard let name = credentials.fullName?.givenName else { return }
        guard let surname = credentials.fullName?.familyName else { return }
        let fullName = "\(name) \(surname)"
        guard let email = credentials.email else { return }
        getUserInfo(fullName: fullName, email: email)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error al hacer el login con el AppleId", error.localizedDescription)
    }
}
