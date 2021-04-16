//
//  Quiz_AppApp.swift
//  Quiz-App
//
//  Created by Phong Le on 14/04/2021.
//

import SwiftUI
import Firebase

@main
struct Quiz_AppApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class Delegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
