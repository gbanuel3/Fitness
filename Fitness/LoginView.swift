//
//  LoginView.swift
//  Fitness
//
//  Created by Gil Banuelos on 8/10/21.
//

import SwiftUI
import Combine

class LoginInformation: ObservableObject {
    @Published var username:String = ""
    @Published var password:String = ""
}

struct LoginView: View {
    
    var body: some View {
        
        VStack{
            Spacer()
            
            TitleView()
                
            Spacer()
            
            ImageView()
            
            Spacer()
        
            FieldsView()
            
            Spacer()
            
            loginButton()
            
            Spacer()
        }
        .padding()
        
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

struct loginButtonStyle: View {
    var body: some View {
        Text("Login")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15)
    }
}

struct FieldsView: View {
    @ObservedObject var loginInfo: LoginInformation = LoginInformation()
    var body: some View {
        TextField("Username", text: $loginInfo.username)
            .padding()
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.002, brightness: 0.955)/*@END_MENU_TOKEN@*/)
            .cornerRadius(5)
            .padding(.bottom, 10.0)
        SecureField("Password", text: $loginInfo.password)
            .padding()
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.953)/*@END_MENU_TOKEN@*/)
            .cornerRadius(5)
            .padding(.bottom, 20.0)
    }
}

struct loginButton: View {
    var body: some View {
        Button(action: onPressLogin){
            loginButtonStyle()
        }
    }
}

func onPressLogin(){
    print("Button Pressed!")
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

