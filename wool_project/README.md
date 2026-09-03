# Wool App

A Flutter mobile application built for my mother to upload, organize, and manage a catalog of her handmade knitted items.

> This project was built through an AI-assisted development workflow (vibe coding). It is not described as an AI-powered product because it does not currently provide an end-user AI feature.

## Overview

Wool App is a catalog-management application for a handmade knitting business.

It gives the maker a simple way to create a digital collection of knitted products. She can upload product photos and maintain key details such as the item name, description, price, and availability.

This was built as a practical family-use project while I explored AI-assisted mobile application development.

## Features

- Create and manage a catalog of handmade knitted items
- Upload and display product images
- Store item details such as name, description, price, and availability
- Browse saved products in one organized place
- Responsive, cross-platform Flutter application
- Local storage and backend integration support

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Backend:** Supabase
- **Local Database:** SQLite using `sqflite`
- **State Management:** Provider
- **Routing:** go_router
- **Image Handling:** image_picker and cached_network_image
- **Media:** video_player
- **Local Storage:** shared_preferences and path_provider
- **UI:** Material Design, Google Fonts, and Flutter Animate

## AI-Assisted Development

This application was created using an AI-assisted workflow, also called vibe coding.

AI tools supported:

- UI generation and refinement
- Flutter implementation guidance
- Package integration and dependency troubleshooting
- Debugging and improving code structure
- Faster iteration on screens and user flows

The app’s goal is catalog management for handmade products, not an AI feature for users.

## Getting Started

### Prerequisites

Install:

- Flutter SDK
- Android Studio, Xcode, or another Flutter-supported development environment
- A physical device or emulator

Check your Flutter installation:

```bash
flutter doctor
```

### Installation

1. Clone the repository:

```bash
git clone https://github.com/vedp9/vibe-coded-apps.git
```

2. Move into the project folder:

```bash
cd vibe-coded-apps/wool_project
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

## Project Structure

```text
wool_project/
├── android/            # Android configuration
├── assets/             # Images and static assets
├── ios/                # iOS configuration
├── lib/                # Application source code
├── test/               # Tests
├── web/                # Web configuration
├── pubspec.yaml        # App dependencies and configuration
└── README.md
```

## Future Improvements

- Add authentication for catalog owners
- Add product categories and search
- Add edit and delete product functionality
- Add a shareable public product catalog
- Add screenshots and a short app demo
- Store environment credentials securely using environment variables

## Author

**Veda Praneeth**

- GitHub: [@vedp9](https://github.com/vedp9)

## License

This project is for learning and portfolio purposes.
