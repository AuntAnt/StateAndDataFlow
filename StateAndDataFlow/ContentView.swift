//
//  ContentView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 26.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timer = TimeCounter()
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        VStack {
            Text("Hi, \(userSettings.name)")
                .font(.largeTitle)
                .padding(.top, 100)
            Text(timer.counter.formatted())
                .font(.largeTitle)
                .padding(.top, 100)
            Spacer()
            
            TimerButtonView(timer: timer)
            
            Spacer()
            
            LogOutButtonView(userSettings: _userSettings)
        }
        .padding()
    }
}

struct TimerButtonView: View {
    @ObservedObject var timer: TimeCounter
    
    var body: some View {
        ButtonView(title: timer.buttonTitle, color: .red, action: timer.startTimer)
    }
}

struct LogOutButtonView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ButtonView(title: "Log Out", color: .blue) {
            userSettings.isLoggedIn = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())
    }
}
