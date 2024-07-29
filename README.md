# MyNews App

MyNews is a Flutter application designed to display the top headlines from a specified country using the NewsAPI. The app utilizes Firebase for authentication and Remote Config to dynamically update the country code for fetching news. This project showcases the integration of various services and follows industry-standard practices for mobile app development.



## Features

- **Firebase Authentication**: Supports email and password authentication.
- **User Data Collection**: Collects and stores user details (name, email) in Firestore under the user collection.
- **News Feed**: Displays the top headlines from a specified country fetched from NewsAPI.
- **Remote Config**: Dynamically updates the country code and API key used to fetch news from Firebase Remote Config.
- **Form Validation**: Includes proper form validation for login and sign-up screens.
- **Error Handling**: Implements error handling for API and Firebase interactions.
- **State Management**: Utilizes Provider for state management.
- **MVVM Architecture**: The app follows the MVVM (Model-View-ViewModel) architecture for organized code structure and separation of concerns.
- **Custom Font**: Uses the "Poppins" font from Google Fonts for a clean and modern look.


## Project Structure


models/: Contains data models
providers/: State management using Provider
services/: API and Firebase services
views/: UI-related code (screens and widgets)
utils/: Utility classes and functions

## Prerequisites

- Flutter SDK >= v3.7.10: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Firebase Project: [Create a Firebase Project](https://firebase.google.com/)
- NewsAPI Key: [Get API Key](https://newsapi.org/)

## dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2 
  firebase_auth: ^4.16.0 
  cloud_firestore: ^4.14.0 
  provider: ^6.1.2 
  http: ^0.13.6 
  firebase_remote_config: ^4.3.8
  google_fonts: ^4.0.4
  shimmer: ^3.0.0
  intl: ^0.18.1



## Optimized App
To build the APK with optimized size, use the following command:

```sh
flutter build apk --split-per-abi
```

This command generates separate APKs for different ABIs (Application Binary Interfaces), resulting in smaller APK sizes. Users download only the APK that matches their device's ABI, reducing download time and saving storage space.


**App Build** : https://drive.google.com/file/d/1MuL4o0pG8erQeWwOazNBtHeP541gFXHi/view?usp=sharing
**Video Demonstration** : https://drive.google.com/file/d/1ES0HDRxqfoyh90jWvm-QEtrDxPvzcQeJ/view?usp=sharing





## Setup

### Step 1: Clone the Repository

```sh
git clone https://github.com/nikhar-tale/MyNews.git
```
