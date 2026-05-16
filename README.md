# Flutter Blogs Demo App

A modern Flutter application for reading and publishing blog posts with authentication powered by Supabase and Firebase.

## Features

- **User Authentication**
  - Sign up with email and password
  - Login with existing credentials
  - Secure logout

- **Blog Management**
  - Browse all published blogs
  - Read individual blog posts with rich formatting
  - Create and upload new blog posts
  - Add cover images to blogs
  - Calculate and display reading time

- **Offline Support**
  - Local data caching with Hive
  - Seamless synchronization with backend

- **User Profiles**
  - User information management
  - Blog author details

## Tech Stack

- **Frontend**: Flutter
- **State Management**: BLoC pattern (flutter_bloc)
- **Backend Services**: Supabase
- **Local Storage**: Hive, isar
- **Authentication**: Supabase Auth
- **Network**: Internet connectivity checking
- **Image Handling**: Image picker
- **UI Components**: Custom widgets with gradient buttons

## Project Structure

```
lib/
├── core/
│   ├── common/          # Shared entities and widgets
│   ├── errors/          # Exception and failure handling
│   ├── network/         # Network connectivity checker
│   ├── secrets/         # API keys (not committed)
│   ├── theme/           # App theming and color palette
│   ├── usecase/         # Base UseCase class
│   └── utils/           # Utility functions
├── features/
│   ├── auth/            # Authentication feature
│   │   ├── data/        # Data layer (datasources, models, repos)
│   │   ├── domain/      # Domain layer (entities, repos, usecases)
│   │   └── presentation/ # UI layer (BLoC, pages, widgets)
│   └── blogs/           # Blogs feature (similar structure)
├── init_dependences.dart # Dependency injection setup
└── main.dart            # App entry point
```

##  Getting Started

### Prerequisites

- Flutter SDK (v3.10.7+)
- Dart SDK
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/amrtrg0308-art/Flutter_Blogs_Demo_App.git
   cd Flutter_Blogs_Demo_App
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up secrets file**
   Create `lib/core/secrets/app_secrets.dart`:
   ```dart
   const String supabaseUrl = 'your_supabase_url';
   const String supabaseAnonKey = 'your_supabase_anon_key';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Linux
- ✅ macOS
- ✅ Windows

## Architecture

This project follows **Clean Architecture** with clear separation of concerns:

- **Presentation Layer**: UI, BLoCs, pages, and widgets
- **Domain Layer**: Business logic, entities, and usecases
- **Data Layer**: API calls, local storage, and data models

##  External Services

- **Supabase**: Real-time database, authentication, and storage
- **Firebase**: Cloud Firestore for blog data
- **Google Sign-In**: Social authentication

##  Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 👤 Author

**Ammar**
- GitHub: [@amrtrg0308-art](https://github.com/amrtrg0308-art)


