# Firebase Setup Instructions for Micro-Blog

## Prerequisites
- Flutter SDK installed
- Firebase CLI installed (run `npm install -g firebase-tools`)
- A Google account

## Step-by-Step Firebase Setup

### 1. Install FlutterFire CLI
```bash
dart pub global activate flutterfire_cli
```

### 2. Login to Firebase
```bash
firebase login
```

### 3. Create a Firebase Project
- Go to [Firebase Console](https://console.firebase.google.com/)
- Click "Add Project"
- Enter project name: "microblog-app" (or your preferred name)
- Follow the setup wizard

### 4. Configure FlutterFire
Run this command in your project root directory:
```bash
cd mobile_app
flutterfire configure
```

This will:
- Create a Firebase project or select an existing one
- Register your app with Firebase
- Generate `firebase_options.dart` file
- Configure iOS, Android, and Web platforms

### 5. Enable Firebase Authentication
1. Go to Firebase Console → Your Project
2. Click on "Authentication" in the left sidebar
3. Click "Get Started"
4. Enable "Email/Password" sign-in method
5. Click "Save"

### 6. Enable Cloud Firestore
1. Go to Firebase Console → Your Project
2. Click on "Firestore Database" in the left sidebar
3. Click "Create Database"
4. Choose "Start in test mode" (for development)
5. Select a Cloud Firestore location
6. Click "Enable"

### 7. Set Up Firestore Security Rules (Important!)
Go to Firestore → Rules tab and replace with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Posts collection
    match /posts/{postId} {
      // Anyone can read public posts
      allow read: if resource.data.isPublic == true;
      
      // Authenticated users can read their own posts (public or private)
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;
      
      // Only authenticated users can create posts
      allow create: if request.auth != null && 
                      request.resource.data.userId == request.auth.uid;
      
      // Only post owner can update their posts
      allow update: if request.auth != null && 
                      resource.data.userId == request.auth.uid;
      
      // Only post owner can delete their posts
      allow delete: if request.auth != null && 
                      resource.data.userId == request.auth.uid;
    }
  }
}
```

Click "Publish"

### 8. Update main.dart (if firebase_options.dart was generated)
If FlutterFire CLI generated `firebase_options.dart`, update the Firebase initialization in `main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Add this parameter
  );
  runApp(const MyApp());
}
```

### 9. Run the App
```bash
# For Android
flutter run

# For iOS (requires Xcode on macOS)
flutter run -d ios

# For Web
flutter run -d chrome
```

## Troubleshooting

### Issue: FlutterFire CLI not found
**Solution:** Make sure Dart SDK bin directory is in your PATH
- Windows: Add `%USERPROFILE%\AppData\Local\Pub\Cache\bin` to PATH
- macOS/Linux: Add `$HOME/.pub-cache/bin` to PATH

### Issue: Firebase initialization fails
**Solution:** 
- Make sure `firebase_options.dart` exists in the lib folder
- Run `flutterfire configure` again
- Check that Firebase project is properly set up in console

### Issue: Authentication errors
**Solution:**
- Verify Email/Password authentication is enabled in Firebase Console
- Check Firestore security rules are published
- Ensure you're using the correct Firebase project

### Issue: Firestore permission denied
**Solution:**
- Check Firestore security rules in Firebase Console
- Make sure user is authenticated before accessing Firestore
- Verify rules allow the operation you're trying to perform

## Testing the App

### Create Test User
1. Run the app
2. Click "Register"
3. Enter:
   - Full Name: Test User
   - Email: test@example.com
   - Password: test123

### Test Features
- ✅ Register new account
- ✅ Login with credentials
- ✅ View public feed
- ✅ Create public post
- ✅ Create private post
- ✅ Edit own posts
- ✅ Delete own posts
- ✅ View private feed
- ✅ View profile
- ✅ Logout

## Database Structure

### Users Collection
```
users/
  {userId}/
    - id: string
    - email: string
    - fullName: string
    - createdAt: timestamp
```

### Posts Collection
```
posts/
  {postId}/
    - id: string
    - userId: string
    - userName: string
    - content: string
    - isPublic: boolean
    - createdAt: timestamp
    - updatedAt: timestamp (optional)
```

## Production Deployment

Before deploying to production:

1. **Update Firestore Rules** to production mode:
   - Remove test mode rules
   - Add proper validation
   - Implement rate limiting

2. **Enable Email Verification** (optional):
   - Firebase Console → Authentication → Templates
   - Customize email verification template

3. **Set up Indexes** (if needed):
   - Firebase will suggest indexes when needed
   - Add them through Firebase Console

4. **Configure App Check** (recommended):
   - Protects your backend resources from abuse
   - Firebase Console → App Check

## Support

For more information, visit:
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Flutter Documentation](https://docs.flutter.dev/)
