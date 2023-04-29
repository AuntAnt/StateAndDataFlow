//
//  LoginView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 26.04.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var name = ""
    @State private var characterCount = 0
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Enter your name", text: $name)
                    .multilineTextAlignment(.center)
                    .onChange(of: name) { characterCount = $0.count }
                Button(action: login) {
                    HStack {
                        Image(systemName: "checkmark.circle")
                        Text("Ok")
                    }
                }
                .disabled(characterCount < 3)
            }
            CharactersCountView(
                count: $characterCount,
                color: characterCount < 3 ? .red : .green
            )
            .padding(EdgeInsets(top: 0, leading: 250, bottom: 26, trailing: 0))
        }
    }
    
    private func login() {
        if !name.isEmpty {
            userSettings.name = name
            userSettings.isLoggedIn.toggle()
        }
    }
}

struct CharactersCountView: View {
    @Binding var count: Int
    
    let color: Color
    
    var body: some View {
        Text(count.formatted())
            .foregroundColor(color)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
