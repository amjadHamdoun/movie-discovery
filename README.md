Movie Discovery App

This project is a Movie Discovery application built with Flutter using Clean Architecture principles. It allows users to explore movies, view detailed information, watch trailers, and mark movies as favorites.

📱 Setup Instructions

Prerequisites

Flutter installed (Installation Guide)

Dart SDK

Android Studio / Xcode (for Android/iOS builds)

VSCode (optional but recommended)

Step-by-Step Setup

Clone the Repository:

git clone https://github.com/your-repo/movie-discovery-app.git
cd movie-discovery-app

Install Dependencies:

flutter pub get

Set Up API Keys:

Obtain an API key from TMDb.

Add the API key in lib/core/constants/constants.dart.

Run the App:

flutter run

Running on iOS

Ensure you have installed CocoaPods dependencies:

cd ios
pod install
cd ..
flutter run

🛠️ Assumptions

The app uses TMDb API for movie data.

Clean Architecture principles are applied with BLoC for state management.

Hive is used for offline caching and favorite movies.

#🧪 Running Unit Tests

#Run All Tests:

flutter test

#Run Tests in a Specific Directory:

flutter test test/home/data/data_sources/movies_api_test.dart
flutter test test/home/data/repositories/movies_repository_impl_test.dart


Check Test Coverage:

flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

🔍 Directory Structure Overview

lib/
├── core/
├── features/
│    ├── home/
│    ├── movie_details/
│    └── search/
└── main.dart

⚠️ Troubleshooting

Missing iOS Device: Open Xcode and trust the device.

API Errors: Check your API key in constants.dart.

Hive Issues: Run flutter clean and then flutter pub get.