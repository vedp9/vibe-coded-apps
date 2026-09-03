# Wool App

A cross-platform mobile application built with Flutter as part of my app-development and AI-assisted building journey.

> Note: This project was created using AI-assisted development (vibe coding) for ideation, implementation support, debugging, and iteration. It should not be described as an AI-powered application unless an AI feature is added to the product.

## Overview

Wool App is a Flutter-based mobile application developed to explore end-to-end app development, including user interfaces, navigation, media handling, local storage, and backend integration.

The project is structured to run across Android, iOS, web, Windows, macOS, and Linux through Flutter.

## Features

- Cross-platform Flutter application
- Multi-page navigation using `go_router`
- Image selection using `image_picker`
- Image caching with `cached_network_image`
- Video playback support
- Local preferences with `shared_preferences`
- Local database support using SQLite
- Backend integration with Supabase
- Custom fonts, animations, and responsive UI components

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Backend:** Supabase
- **Database:** SQLite / `sqflite`
- **State Management:** Provider
- **Routing:** go_router
- **Media:** image_picker, video_player
- **Storage:** shared_preferences, path_provider
- **UI:** Google Fonts, Flutter Animate, Material Design

## AI-Assisted Development

This project was developed with AI-assisted coding workflows, also known as vibe coding.

AI tools were used to support tasks such as:

- Generating and refining Flutter UI code
- Troubleshooting implementation issues
- Exploring package integrations
- Improving code structure and development speed
- Iterating on screens and user flows

The application currently focuses on mobile app development rather than providing an AI-powered feature to end users.

## Getting Started

### Prerequisites

Install the following:

- Flutter SDK (Dart SDK included)
- Android Studio, Xcode, or another Flutter-supported development environment
- A physical device or emulator

Verify your Flutter setup:

```bash
flutter doctor
```

### Installation

1. Clone the repository:

```bash
git clone https://github.com/vedp9/ai-engineered-apps-journey.git
```

2. Navigate to this project folder:

```bash
cd ai-engineered-apps-journey/wool_project
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Project Structure

```text
wool_project/
├── android/            # Android configuration
├── assets/             # Images, videos, fonts, and other app assets
├── ios/                # iOS configuration
├── lib/
│   ├── pages/          # Application screens
│   └── main.dart       # Application entry point
├── test/               # Flutter tests
├── web/                # Web configuration
├── pubspec.yaml        # Packages and app configuration
└── README.md
```

## Future Improvements

- Add a clearly defined product description and user problem
- Add screenshots or a short demo video
- Improve test coverage
- Add environment-variable configuration for Supabase credentials
- Add authentication and user profiles, if relevant
- Add a real AI-powered feature, such as smart recommendations or an in-app assistant

## Author

**Veda Praneeth**

- GitHub: [@vedp9](https://github.com/vedp9)

## License

This project is for learning and portfolio purposes.
