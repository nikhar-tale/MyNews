# MyNews App

MyNews is a Flutter application designed to display the top headlines from a specified country using the NewsAPI. The app utilizes Firebase for authentication and Remote Config to dynamically update the country code for fetching news. This project showcases the integration of various services and follows industry-standard practices for mobile app development.

## Features

- **Firebase Authentication**: Supports email and password authentication.
- **User Data Collection**: Collects and stores user details (name, email) in Firestore under the user collection.
- **News Feed**: Displays the top headlines from a specified country fetched from NewsAPI.
- **Remote Config**: Dynamically updates the country code used to fetch news from Firebase Remote Config.
- **Form Validation**: Includes proper form validation for login and sign-up screens.
- **Error Handling**: Implements error handling for API and Firebase interactions.
- **State Management**: Utilizes Provider for state management.
- **MVVM Architecture**: The app follows the MVVM (Model-View-ViewModel) architecture for organized code structure and separation of concerns.

## Project Structure


models/: Contains data models
providers/: State management using Provider
services/: API and Firebase services
ui/: UI-related code (screens and widgets)
utils/: Utility classes and functions

## Prerequisites

- Flutter SDK >= v3.7.10: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Firebase Project: [Create a Firebase Project](https://firebase.google.com/)
- NewsAPI Key: [Get API Key](https://newsapi.org/)


## Setup

### Step 1: Clone the Repository

```sh
git clone https://github.com/your-username/MyNews.git
cd MyNews



