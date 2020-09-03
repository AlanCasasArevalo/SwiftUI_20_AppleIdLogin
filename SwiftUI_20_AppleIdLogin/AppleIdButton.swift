
import SwiftUI
import AuthenticationServices

struct AppleIdButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let appleIDButton = ASAuthorizationAppleIDButton()
        return appleIDButton
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
}

class LoginAppleId: NSObject, ASAuthorizationControllerDelegate {
    func getAppleRequest () {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.delegate = self
        authController.performRequests()
    }
    
    func getUserInfo(userId: String, name: String?, email: String?) {
        let user = UserModel(name: name, email: email)
        if let userEncoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(userEncoded, forKey: "userEncoded")
        }
    }
}
