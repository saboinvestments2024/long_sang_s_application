# 📖 PROJECT CONTEXT FOR COPILOTS
*Auto-generated context file for seamless collaboration*

## 🎯 PROJECT OVERVIEW
**Name**: SANG'S APPLICATION  
**Type**: Flutter Mobile App (Billiards Club Management)  
**Architecture**: Clean Architecture + Riverpod  
**Target**: iOS & Android  
**Current Status**: 85% UI Complete, Backend Integration Needed

---

## 🏗️ CURRENT ARCHITECTURE

### **Tech Stack**
```yaml
flutter: ^3.6.0
flutter_riverpod: ^2.5.1
equatable: ^2.0.5
# Material Design 3 with custom theming
```

### **Project Structure**
```
lib/
├── core/               # Core utilities and services
├── presentation/       # UI screens and widgets
│   ├── club_profile_screen/
│   ├── user_profile_screen/
│   └── app_navigation_screen/
├── routes/             # Navigation configuration
├── theme/              # Custom theme system
├── widgets/            # Reusable UI components
└── main.dart           # App entry point
```

---

## 📱 IMPLEMENTED FEATURES

### ✅ **Club Profile Screen**
- **Header**: @sabobilliards with menu
- **Hero Image**: Club photo with "SABO Billiards" overlay
- **Location**: 601A Nguyễn An Ninh - TP Vũng Tàu
- **Stats**: 25 Members, 15 Tournaments, 89.9M Prize Pool, 37 Challenges
- **Member List**: Anh Long Magic (Rank G), SABO (Rank H)

### ✅ **User Profile Screen**
- **Header**: @longsang with menu
- **Hero Image**: User photo with "Anh Long Magic" overlay
- **Rank Badge**: RANK : G
- **Stats**: 1485 ELO, 320 SPA, #89 XH, 37 MATCHES
- **Tabs**: Ready, Live, Done
- **Tournament List**: SABO POOL & BALL matches

### ✅ **Navigation System**
- **Bottom Navigation**: 5 tabs with special tournament tab styling
- **Custom Widgets**: CustomAppBar, CustomBottomNavigationBar
- **Routing**: Traditional Navigator (planned: Go_Router migration)

---

## 🎨 DESIGN SYSTEM

### **Color Palette**
```dart
// Primary
deep_purple_A700: #6403C8
deep_purple_900: #0414AC
white_A700: #FFFFFF
black_900: #000000

// Secondary
blue_gray_100: #D7D7D9
blue_200: #A0B2F8
indigo_300: #7792E2
```

### **Typography**
- **Inter**: Headers and titles
- **Roboto**: Body text and UI elements
- **ABeeZee**: Tab labels and buttons
- **Alumni Sans**: Display text

### **Theme Usage**
```dart
// Access theme colors
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
```

---

## 🔧 STATE MANAGEMENT

### **Riverpod Structure**
```dart
// Provider pattern
final clubProfileNotifier = StateNotifierProvider.autoDispose<ClubProfileNotifier, ClubProfileState>

// State classes
class ClubProfileState extends Equatable {
  final ClubProfileModel? clubProfileModel;
  final List<MemberItemModel>? membersList;
}

// Usage in widgets
class ClubProfileScreen extends ConsumerStatefulWidget {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clubProfileNotifier);
    // UI implementation
  }
}
```

---

## 📋 CURRENT DATA MODELS

### **User Profile Model**
```dart
class UserProfileModel {
  String? username;        // 'longsang'
  String? displayName;     // 'Anh Long Magic'
  String? rank;           // 'G'
  String? elo;            // '1485'
  String? spa;            // '320'
  String? xh;             // '#89'
  String? matches;        // '37'
  List<TournamentCardModel>? tournaments;
}
```

### **Club Profile Model**
```dart
class ClubProfileModel {
  String? membersCount;      // '25'
  String? tournamentsCount;  // '15'
  String? prizePool;         // '89.9 Tr'
  String? challengesCount;   // '37'
}
```

### **Tournament Card Model**
```dart
class TournamentCardModel {
  String? ballNumber;        // '8'
  String? title;            // 'SABO POOL 8 BALL'
  String? date;             // '07/09 - Thứ 7'
  String? participants;     // '0/16'
  String? level;            // 'K - I+'
  String? prize;            // '10 Million'
  String? networkCount;     // '2 Mạng'
}
```

---

## 🚧 KNOWN ISSUES & GAPS

### **Critical Issues**
1. **Data Layer**: All data is hardcoded in notifiers
2. **API Integration**: No backend connection
3. **Navigation**: Using traditional Navigator instead of Go_Router
4. **Error Handling**: Missing error states and loading indicators

### **UI Improvements Needed**
1. **Images**: Replace placeholders with real images
2. **Animations**: Add smooth transitions
3. **Responsive**: Test on different screen sizes
4. **Accessibility**: Add semantic labels

---

## 🎯 IMMEDIATE PRIORITIES

### **P1 - Critical**
- [ ] Supabase setup and configuration
- [ ] Repository pattern implementation
- [ ] Go_Router migration
- [ ] Real image assets

### **P2 - High**
- [ ] Error handling and loading states
- [ ] Complete tab functionality
- [ ] API service layers
- [ ] Tournament details screen

### **P3 - Medium**
- [ ] Animations and transitions
- [ ] Performance optimization
- [ ] Unit testing
- [ ] Accessibility improvements

---

## 📁 KEY FILES TO REFERENCE

### **Entry Points**
- `lib/main.dart` - App initialization
- `lib/routes/app_routes.dart` - Navigation setup
- `lib/core/app_export.dart` - Central imports

### **Screens**
- `lib/presentation/club_profile_screen/club_profile_screen.dart`
- `lib/presentation/user_profile_screen/user_profile_screen.dart`
- `lib/presentation/user_profile_screen/user_profile_screen_initial_page.dart`

### **State Management**
- `lib/presentation/club_profile_screen/notifier/club_profile_notifier.dart`
- `lib/presentation/user_profile_screen/notifier/user_profile_notifier.dart`

### **Custom Widgets**
- `lib/widgets/custom_app_bar.dart`
- `lib/widgets/custom_bottom_navigation_bar.dart`
- `lib/widgets/custom_image_view.dart`

### **Theme & Styling**
- `lib/theme/theme_helper.dart`
- `lib/theme/text_style_helper.dart`

---

## 🔐 CRITICAL RULES

### **NEVER MODIFY**
```yaml
# In pubspec.yaml
flutter:
  sdk: flutter
flutter_test:
  sdk: flutter
uses-material-design: true
```

### **ALWAYS PRESERVE**
```dart
// In main.dart
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])

// Text scaling control
MediaQuery(
  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
  child: child!,
)
```

---

## 📊 CURRENT STATS
- **Lines of Code**: ~2,500
- **Screens**: 3 implemented
- **Custom Widgets**: 5 created
- **Models**: 4 data classes
- **Test Coverage**: 0% (needs implementation)

**Last Updated**: September 8, 2025 - 9:41 AM
