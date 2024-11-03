import SwiftUI
import SpotifyiOS
import Combine

class SpotifyManager: NSObject, ObservableObject, SPTSessionManagerDelegate {
    @Published var accessToken: String? {
        didSet {
            if let token = accessToken {
                // Save the access token to UserDefaults
                UserDefaults.standard.set(token, forKey: "SpotifyAccessToken")
                // Fetch available devices once we have the access token
                fetchAvailableDevices(accessToken: token)
            }
        }
    }
    @Published var availableDevices: [SpotifyDevice] = []
    
    let SpotifyClientID = "7bf1838791914338a4969de74c01b388"
    let SpotifyRedirectURL = URL(string: "senseMEE://callback")!
    
    lazy var sessionManager: SPTSessionManager = {
        let configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURL)
        return SPTSessionManager(configuration: configuration, delegate: self)
    }()
    
    func authenticate() {
        let scope: SPTScope = [.playlistReadPrivate, .userReadPlaybackState, .userModifyPlaybackState]
        sessionManager.initiateSession(with: scope, options: .default)
    }
    
    func handleURL(_ url: URL) {
        sessionManager.application(UIApplication.shared, open: url, options: [:])
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Spotify session initiated")
        DispatchQueue.main.async {
            self.accessToken = session.accessToken
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Failed to initiate Spotify session: \(error.localizedDescription)")
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Spotify session renewed")
    }
    
    // Fetch available devices
    func fetchAvailableDevices(accessToken: String) {
        let url = URL(string: "https://api.spotify.com/v1/me/player/devices")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching available devices: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let devicesResponse = try JSONDecoder().decode(SpotifyDevicesResponse.self, from: data)
                DispatchQueue.main.async {
                    self.availableDevices = devicesResponse.devices
                }
            } catch {
                print("Failed to decode devices response: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}

// Struct to decode Spotify devices response
struct SpotifyDevicesResponse: Codable {
    let devices: [SpotifyDevice]
}

struct SpotifyDevice: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let isRestricted: Bool
    let name: String
    let type: String
    let volumePercent: Int?
}

