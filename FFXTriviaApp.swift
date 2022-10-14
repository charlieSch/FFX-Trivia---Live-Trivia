    //
//  FFXTriviaApp.swift
//  FFXTrivia
//
//  Created by Charlie Schmidt on 7/27/22.
//

import SwiftUI
import Firebase



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

//just main file to call the views

@main

struct FFXTriviaApp: App {

  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
      
    WindowGroup {
        
      NavigationView {
          
        ContentView()
          
      }
        
    }
      
  }
    
}

