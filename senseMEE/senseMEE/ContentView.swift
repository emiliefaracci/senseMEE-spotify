import SwiftUI

struct ContentView: View {
    @EnvironmentObject var spotifyManager: SpotifyManager
    @EnvironmentObject var sensorDataManager: SensorDataManager

    var body: some View {
        VStack {
            Text("Activity Prediction")
                .font(.largeTitle)
                .padding()
            
            Text(sensorDataManager.predictedActivity)
                .font(.title)
                .padding()
                .foregroundColor(.blue)
            
            Spacer()
            
            if spotifyManager.accessToken != nil {
                Text("Authenticated")
            } else {
                Button("Authenticate with Spotify") {
                    spotifyManager.authenticate()
                }
            }
        }
        .onAppear {
            sensorDataManager.startDataCollectionLoop()
        }
        .onOpenURL { url in
            spotifyManager.handleURL(url)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SpotifyManager())
            .environmentObject(SensorDataManager(spotifyManager: SpotifyManager()))
    }
}

