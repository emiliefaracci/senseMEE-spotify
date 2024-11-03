# Ambient Spotify
## Automated Playlist Controller using iPhone sensor data for activity detection

## Collaborators: 
- Elizabeth Li
- Matthew Jeung

**Time:** Two Weeks
**Main Tools Used:** Swift, CoreML, Spotify API


## Introduction

Sense MEE is a mobile application designed to automate the selection of playlists based on a user's current activity and environmental context. By leveraging smartphone sensors such as the gyroscope and accelerometer, along with publicly available time and weather data, the app curates personalized music recommendations that fit the user's vibe without any additional distractions.

## Background
While current music streaming platforms offer personalized playlist curation, they often fail to adapt to real-time contextual changes. Sense MEE aims to bridge this gap by using machine learning to classify the user's environment and activity, enabling a seamless listening experience that reflects the user's current state.

## Features

- **Automated Playlist Selection:** The app classifies the user's activity and selects playlists that match their current "vibe," such as Calm & Mellow, Bright & Happy, Hype & Energizing, Emo Rock, and Sleep Mode.

- **Continuous Sensing:** Utilizing a 5-second sliding window for data collection, the app updates music selection every second to ensure real-time responsiveness.

- **User Customization:** Users can curate their playlists by adding personal song choices under each vibe category, allowing for a tailored music experience.

- **Spotify Integration:** Simple authentication with Spotify allows users to enjoy a hands-free music experience without needing to interact with the app once it's set up.

## Evaluation

The effectiveness of Sense MEE was evaluated through external user testing. Key findings include:

- **Battery Consumption:** The app demonstrated low energy impact after initial location and API requests, stabilizing after about one minute.
- **Accuracy of Classifier:** User feedback on the accuracy of activity classification was collected during various scenarios to refine the system.

After installation, open the Sense MEE app and authenticate with Spotify. The app will automatically detect your activity and environmental conditions to play the most suitable playlist based on your preferences.

