import UIKit
import SpotifyiOS
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate, SPTSessionManagerDelegate {
    var window: UIWindow?
    let SpotifyClientID = "7bf1838791914338a4969de74c01b388"
    let SpotifyRedirectURL = URL(string: "senseMEE://callback")!

    lazy var sessionManager: SPTSessionManager = {
        let configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURL)
        return SPTSessionManager(configuration: configuration, delegate: self)
    }()

    var spotifyManager = SpotifyManager()
    var sensorDataManager: SensorDataManager?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        sensorDataManager = SensorDataManager(spotifyManager: spotifyManager)

        // Create the SwiftUI view and set the context as the window's root view controller.
        let contentView = ContentView()
            .environmentObject(spotifyManager)
            .environmentObject(sensorDataManager!)

        // Use a UIHostingController as window root view controller.
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }

        return true
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        sessionManager.application(application, open: url, options: options)
        return true
    }

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Spotify session initiated")
        DispatchQueue.main.async {
            self.spotifyManager.accessToken = session.accessToken
        }
    }

    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Failed to initiate Spotify session: \(error.localizedDescription)")
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Spotify session renewed")
        DispatchQueue.main.async {
            self.spotifyManager.accessToken = session.accessToken
        }
    }
}

