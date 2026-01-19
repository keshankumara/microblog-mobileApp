# 📱 Micro-Blog Mobile Application

A lightweight and user-friendly mobile application designed for sharing short text-based posts quickly and securely. Built with Flutter and Firebase.

## ✨ Features

### 👤 User Management
- **User Registration** - Create new accounts with email and password
- **User Login** - Secure authentication system
- **Session Handling** - Persistent login state
- **Profile Management** - View and manage user information
- **Logout** - Secure sign out functionality

### 📝 Post Management
- **Create Posts** - Write and share your thoughts
- **Edit Posts** - Modify your existing posts
- **Delete Posts** - Remove unwanted content
- **Public/Private Toggle** - Control post visibility
- **Real-time Updates** - Live feed updates

### 🌍 Public Feed
- View all public posts from all users
- Sorted by latest first
- Clean card-based layout
- Pull to refresh
- Empty state handling

### 🔐 Private Feed
- View only your private posts
- Personal journaling space
- Protected access control
- Same familiar interface

### 🎨 Modern UI/UX
- Clean and minimal design
- Smooth animations
- Responsive layout
- Beautiful color palette
- Easy navigation with bottom navigation bar

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase account
- Firebase CLI

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd microblog-mobileApp/mobile_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Set up Firebase**
Follow the detailed instructions in [FIREBASE_SETUP.md](FIREBASE_SETUP.md)

Quick setup:
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

4. **Run the app**
```bash
# For Android
flutter run

# For iOS
flutter run -d ios

# For Web
flutter run -d chrome
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # Firebase
  firebase_core: ^3.9.0
  firebase_auth: ^5.3.4
  cloud_firestore: ^5.5.2
  
  # State Management
  provider: ^6.1.2
  
  # Utilities
  intl: ^0.19.0
```

## 🔒 Security

### Firestore Security Rules
The app implements proper security rules to ensure:
- Users can only edit/delete their own posts
- Public posts are visible to everyone
- Private posts are only visible to the owner
- Authentication is required for write operations

### Authentication
- Firebase Authentication with email/password
- Secure session management
- Protected routes
- Automatic logout on session expiry


## 🧪 Testing

### Manual Testing Checklist

**Authentication:**
- [ ] Register new user
- [ ] Login with valid credentials
- [ ] Login with invalid credentials
- [ ] Logout functionality
- [ ] Session persistence

**Post Management:**
- [ ] Create public post
- [ ] Create private post
- [ ] Edit own post
- [ ] Delete own post
- [ ] View posts in real-time

**Navigation:**
- [ ] Bottom navigation works
- [ ] All screens accessible
- [ ] Back button navigation
- [ ] Deep linking (if implemented)

**UI/UX:**
- [ ] Responsive layout
- [ ] Loading states
- [ ] Error handling
- [ ] Empty states
- [ ] Form validation

## 🛠️ Development

### Running in Debug Mode
```bash
flutter run --debug
```

### Building for Release

**Android:**
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

### Code Formatting
```bash
flutter format .
```

### Analyzing Code
```bash
flutter analyze
```


## 👨‍💻 Author

Developed as a mobile application project for educational purposes.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase team for the backend infrastructure
- Material Design for UI inspiration

## 📞 Support

For issues and questions:
- Create an issue on GitHub
- Contact: keshankumara11@gmail.com




