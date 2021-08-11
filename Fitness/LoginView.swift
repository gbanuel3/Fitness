//
//  LoginView.swift
//  Fitness
//
//  Created by Gil Banuelos on 8/10/21.
//

import SwiftUI
import Combine
import RealmSwift

class LoginInformation: ObservableObject {
    @Published var username:String = ""
    @Published var password:String = ""
    @Published var authenticationDidFail:Bool = false
    @Published var authenticationDidSucceed:Bool = true
}

struct LoginView: View {
    @ObservedObject var loginInfo: LoginInformation = LoginInformation()
    @State var showSignupView:Bool = false
    var body: some View {
        ZStack{
            VStack{
                Group{
                    Spacer()
                    TitleView()
                    Spacer()
                    ImageView()
                    Spacer()
                    FieldsView(loginInfo: loginInfo)
                    Spacer()
                    if loginInfo.authenticationDidFail {
                        Text("Incorrect Login Information")
                            .offset(y:-10)
                            .foregroundColor(.red)
                    }
                    
                    loginButton(loginInfo: loginInfo)
                }
                HStack{
                    Text("Don't have an account?")
                    Button(action: {showSignupView = true}){
                        signupButtonStyle()
                    }
                    .fullScreenCover(isPresented: $showSignupView){
                        SignupView()
                    }
                }
            }
            .padding()
            
            if loginInfo.authenticationDidSucceed {
                let capitalizedName = loginInfo.username.prefix(1).capitalized + loginInfo.username.dropFirst()
                Text("Welcome Back, \(capitalizedName)!")
                    .font(.headline)
                    .frame(width: 250, height: 100)
                    .background(Color.green)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .animation(.easeIn(duration: 0.5))
                    .offset(y:-15)
            }
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            Text("Fitness!")
                .font(.system(size: 70))
                .fontWeight(.semibold)
        }
    }
}

struct ImageView: View {
    var body: some View {
        Image("dumbell")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
    }
}

struct FieldsView: View {
    @ObservedObject var loginInfo: LoginInformation
    var body: some View {
        TextField("Username", text: $loginInfo.username)
            .padding()
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.002, brightness: 0.955)/*@END_MENU_TOKEN@*/)
            .cornerRadius(5)
            .padding(.bottom, 10.0)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        SecureField("Password", text: $loginInfo.password)
            .padding()
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.953)/*@END_MENU_TOKEN@*/)
            .cornerRadius(5)
            .padding(.bottom, 20.0)
    }
}

struct loginButton: View {
    @ObservedObject var loginInfo: LoginInformation
    var body: some View {
        Button(action: {onPressLogin(loginInfo: loginInfo)}){
            loginButtonStyle()
        }
    }
}

struct loginButtonStyle: View {
    var body: some View {
        Text("Log In")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15)
    }
}

func onPressLogin(loginInfo: LoginInformation){
    print("Button Pressed!")
    print(loginInfo.username)
    print(loginInfo.password)
    
    let app = App(id: "application-0-ogjxf")

    // Log in anonymously.
    
    app.login(credentials: Credentials.anonymous) { result in
        // Remember to dispatch back to the main thread in completion handlers
        // if you want to do anything on the UI.
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("Login failed: \(error)")
            case .success(let user):
                print("Login as \(user) succeeded!")
            }
        }
    }
    
}

struct signupButtonStyle: View {
    var body: some View {
        Text("Sign Up")
            .font(.body)
            .frame(width: 100, height: 40)
            .padding(.leading, -20)

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

