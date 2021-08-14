//
//  SignupView.swift
//  Fitness
//
//  Created by Gil Banuelos on 8/10/21.
//

import SwiftUI
import RealmSwift
import Combine

class signupInformation: ObservableObject {
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var authenticationDidFail:Bool = false
    @Published var authenticationDidSucceed:Bool = true
}

struct SignupView: View {
    @ObservedObject var signupInfo: signupInformation = signupInformation()
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("First Name", text: $signupInfo.firstName)
                .padding()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.002, brightness: 0.955)/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .padding(.bottom, 10.0)
                TextField("Last Name", text: $signupInfo.lastName)
                .padding()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.002, brightness: 0.955)/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .padding(.bottom, 10.0)
            }
            TextField("Email", text: $signupInfo.email)
            .padding()
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.002, brightness: 0.955)/*@END_MENU_TOKEN@*/)
            .cornerRadius(5)
            .padding(.bottom, 10.0)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            SecureInputView("Password", text: $signupInfo.password)
            .padding()
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.002, brightness: 0.955)/*@END_MENU_TOKEN@*/)
            .cornerRadius(5)
            .padding(.bottom, 10.0)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            signupButton(signupInfo: signupInfo)
            Spacer()
        }
        .padding()

    }
}

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                SecureField(title, text: $text)
            } else {
                TextField(title, text: $text)
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}

struct signupButton: View {
    @ObservedObject var signupInfo: signupInformation
    var body: some View {
        Button(action: {onPressSignUp(signupInfo: signupInfo)}){
            signupButtonStyling()
        }
    }
}
struct signupButtonStyling: View {
    var body: some View {
        Text("Sign Up")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15)
    }
}

func onPressSignUp(signupInfo:signupInformation) {
    
    let app = App(id: "application-0-ogjxf")
    
    app.emailPasswordAuth.registerUser(email: "gbanuel3@gmail.com", password: "Body!Date!73") { Error in
        print(Error)
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
