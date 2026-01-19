# 🚀 Quick Start Guide - Micro-Blog App

## ⚡ Fast Setup (5 minutes)

### Step 1: Firebase Setup
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase (this will create firebase_options.dart)
cd mobile_app
flutterfire configure
```

**Select or create a Firebase project when prompted.**

### Step 2: Enable Firebase Services

Go to [Firebase Console](https://console.firebase.google.com/) and:

1. **Enable Authentication:**
   - Authentication → Sign-in method → Email/Password → Enable

2. **Enable Firestore:**
   - Firestore Database → Create Database → Start in test mode

3. **Set Security Rules:**
   - Firestore → Rules → Copy paste these rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /posts/{postId} {
      allow read: if resource.data.isPublic == true;
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && resource.data.userId == request.auth.uid;
    }
  }
}
```

### Step 3: Update main.dart (Only if firebase_options.dart exists)

If `firebase_options.dart` was created, update `lib/main.dart`:

```dart
import 'firebase_options.dart'; // Add this import at the top

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Add this line
  );
  runApp(const MyApp());
}
```

### Step 4: Run the App
```bash
flutter run
```

## 🎯 First Use

1. **Register an Account:**
   - Click "Register"
   - Enter your details
   - Submit

2. **Create Your First Post:**
   - Tap the yellow "+" button
   - Write your post
   - Choose Public or Private
   - Save

3. **Explore:**
   - Public Feed: See all public posts
   - Private: Your private posts
   - Profile: Your account info

## 📱 Available Commands

```bash
# Run on specific device
flutter run -d android
flutter run -d ios
flutter run -d chrome

# Build release
flutter build apk --release        # Android APK
flutter build appbundle --release  # Android Bundle
flutter build ios --release        # iOS
flutter build web --release        # Web

# Check for issues
flutter doctor
flutter analyze
```

## ⚠️ Troubleshooting

### "FlutterFire CLI not found"
Add Dart bin to PATH:
- Windows: `%USERPROFILE%\AppData\Local\Pub\Cache\bin`
- macOS/Linux: `$HOME/.pub-cache/bin`

### "Firebase initialization failed"
Run: `flutterfire configure` again

### "Permission denied" errors
Check Firestore security rules are published

### Hot reload not working
Try hot restart: Press `R` in terminal or click hot restart button

## 🎨 Customization

### Change Colors
Edit `lib/constants/colors.dart`:
```dart
static const Color primary = Color(0xFF2563EB); // Change this
```

### Change App Name
Edit `lib/constants/strings.dart`:
```dart
static const String appName = 'Your App Name';
```

### Modify Post Character Limit
Edit `lib/screens/create_post_screen.dart`:
```dart
maxLength: 500, // Change this number
```

## 📚 Next Steps

- Read full documentation in `PROJECT_README.md`
- Check Firebase setup details in `FIREBASE_SETUP.md`
- Test all features
- Customize the UI
- Add your own features

## ✅ Feature Checklist

After setup, test these features:
- [ ] Register new account
- [ ] Login
- [ ] Create public post
- [ ] Create private post
- [ ] Edit post
- [ ] Delete post
- [ ] View profile
- [ ] Logout

## 🆘 Need Help?

1. Check `FIREBASE_SETUP.md` for detailed Firebase instructions
2. Check `PROJECT_README.md` for full documentation
3. Run `flutter doctor` to check your setup
4. Check Firebase Console for any errors

---

**You're all set! Happy blogging! 🎉**
