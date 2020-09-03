
import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @Binding var isLogged: Bool

    var body: some View {
        VStack {
            Text("Nombre: \(self.viewModel.user?.name ?? "")")
            Text("Email: \(self.viewModel.user?.email ?? "")")
            
            Button(action: {
                UserDefaults.standard.removeObject(forKey: "userEncoded")
                self.isLogged = false
            }) {
                Text("Salir")
            }
            
        }
        .onAppear{
            self.viewModel.getUserInfo()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isLogged: .constant(false))
    }
}
