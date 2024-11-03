import SwiftUI

@main
struct YourApp: App {
    // Register AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.spotifyManager)
                .environmentObject(appDelegate.sensorDataManager!)
        }
    }
}
