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

## 🎨 Color Palette

The app uses a carefully selected color scheme:

| Purpose | Color Name | Hex Code | Usage |
|---------|-----------|----------|--------|
| **Primary** | Deep Blue | `#2563EB` | AppBar, Buttons |
| **Secondary** | Soft Teal | `#14B8A6` | Links, Highlights |
| **Accent** | Warm Gold | `#F59E0B` | FAB, Actions |
| **Background** | Soft White | `#F9FAFB` | Main Background |
| **Card** | Pure White | `#FFFFFF` | Post Cards |
| **Text Primary** | Dark Gray | `#111827` | Main Text |
| **Text Secondary** | Muted Gray | `#6B7280` | Secondary Text |
| **Success** | Green | `#22C55E` | Success Messages |
| **Error** | Red | `#EF4444` | Error Messages |
| **Border** | Light Gray | `#E5E7EB` | Borders |

## 📁 Project Structure

```
mobile_app/
├── lib/
│   ├── constants/
│   │   ├── colors.dart          # App color palette
│   │   └── strings.dart         # App string constants
│   ├── models/
│   │   ├── post.dart            # Post data model
│   │   └── user_model.dart      # User data model
│   ├── screens/
│   │   ├── login_screen.dart    # Login interface
│   │   ├── register_screen.dart # Registration interface
│   │   ├── home_screen.dart     # Public feed
│   │   ├── private_feed_screen.dart  # Private posts
│   │   ├── create_post_screen.dart   # Create new post
│   │   ├── edit_post_screen.dart     # Edit existing post
│   │   └── profile_screen.dart  # User profile
│   ├── services/
│   │   ├── auth_service.dart    # Authentication logic
│   │   └── post_service.dart    # Post CRUD operations
│   ├── widgets/
│   │   ├── custom_button.dart   # Reusable button
│   │   ├── custom_text_field.dart # Reusable text field
│   │   └── post_card.dart       # Post display card
│   └── main.dart                # App entry point
├── android/                     # Android specific files
├── ios/                         # iOS specific files
├── pubspec.yaml                 # Dependencies
├── FIREBASE_SETUP.md           # Firebase setup guide
└── README.md                    # This file
```

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

## 🎯 User Flow

```
1. User opens app
   ├─→ Not logged in → Login Screen
   │   ├─→ Login → Home Screen
   │   └─→ Register → Registration → Home Screen
   └─→ Logged in → Home Screen

2. Home Screen (Public Feed)
   ├─→ View all public posts
   ├─→ Create new post (FAB)
   ├─→ Edit/Delete own posts
   ├─→ Navigate to Private Feed (Bottom Nav)
   └─→ Navigate to Profile (Bottom Nav)

3. Private Feed
   ├─→ View private posts
   ├─→ Edit/Delete posts
   └─→ Navigate back

4. Profile
   ├─→ View user info
   ├─→ Navigate to feeds
   └─→ Logout
```

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

## 📱 Screens

### 1. Login Screen
- Email/password input
- Form validation
- Link to registration
- Auto-login if session exists

### 2. Registration Screen
- Full name, email, password fields
- Password confirmation
- Form validation
- Creates Firestore user document

### 3. Home Screen (Public Feed)
- Displays all public posts
- Real-time updates
- Post cards with user info
- Edit/delete for own posts
- FAB for creating posts
- Bottom navigation

### 4. Create Post Screen
- Text input field (max 500 chars)
- Public/Private toggle
- Character counter
- Save button

### 5. Edit Post Screen
- Pre-filled content
- Update visibility
- Save changes
- Cancel option

### 6. Private Feed Screen
- Shows only user's private posts
- Same card layout
- Edit/delete options

### 7. Profile Screen
- User avatar (initial)
- User information display
- Quick links to feeds
- Logout button

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

Developed as a mobile application project for educational purposes.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase team for the backend infrastructure
- Material Design for UI inspiration

## 📞 Support

For issues and questions:
- Create an issue on GitHub
- Contact: [Your contact information]

## 🔮 Future Enhancements

Potential features for future versions:
- [ ] User profile pictures
- [ ] Like/comment functionality
- [ ] Search posts
- [ ] User following system
- [ ] Push notifications
- [ ] Dark mode
- [ ] Post categories/tags
- [ ] Image attachments
- [ ] Share posts
- [ ] Password reset
- [ ] Email verification

## 📊 App Statistics

- **Total Screens:** 7
- **Total Models:** 2
- **Total Services:** 2
- **Total Widgets:** 3
- **Lines of Code:** ~2000+
- **Development Time:** Variable

---

**Happy Blogging! 📝✨**
