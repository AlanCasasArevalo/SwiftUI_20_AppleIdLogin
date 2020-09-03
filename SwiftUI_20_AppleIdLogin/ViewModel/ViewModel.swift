
import Foundation

class ViewModel: ObservableObject {
    private var login = LoginAppleId()
    @Published var user: UserModel?
    
    func appleLogin () {
        login.getAppleRequest()
    }
    
    func getUserInfo() {
        guard let userData = UserDefaults.standard.object(forKey: "userEncoded") as? Data else { return }
        guard let userEncoded = try? JSONDecoder().decode(UserModel.self, from: userData) else { return }
        self.user = userEncoded
    }
    
}
