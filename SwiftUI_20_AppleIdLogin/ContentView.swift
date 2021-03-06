import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var isLogged = false
    
    var body: some View {
        return Group {
            
            if isLogged {
                HomeView(isLogged: self.$isLogged)
            } else {
                VStack {
                    Button(action: {
                        self.viewModel.appleLogin()
                    }) {
                        AppleIdButton()
                            .background(Color.primary)
                            .cornerRadius(15, antialiased: true)
                            .frame(width: 200, height: 50)
                    }
                    Button(action: {
                        if UserDefaults.standard.object(forKey: "userEncoded") != nil {
                            self.isLogged = true
                        }
                    }) {
                        Text("Continuar")
                    }
                }
            }
        }
        .padding()
        .onAppear{
            if UserDefaults.standard.object(forKey: "userEncoded") != nil {
                self.isLogged = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
