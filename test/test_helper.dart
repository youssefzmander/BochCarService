import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate mocks with unique names
@GenerateMocks(
  [FirebaseAuth, User, UserCredential],
  customMocks: [
    MockSpec<FirebaseAuth>(as: #GeneratedMockFirebaseAuth),
    MockSpec<User>(as: #GeneratedMockUser),
    MockSpec<UserCredential>(as: #GeneratedMockUserCredential),
  ],
)

// Test helper functions
Future<void> setupFirebaseForTesting() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Setup Firebase Core mocks
  setupFirebaseCoreMocks();
  
  // Initialize Firebase
  await Firebase.initializeApp();
}

Future<void> setupFirebaseCoreMocks() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Create a mock Firebase app
  final mockApp = MockFirebaseApp();
  when(mockApp.name).thenReturn('[DEFAULT]');
  when(mockApp.options).thenReturn(MockFirebaseOptions());
  
  // Setup Firebase Core mocks
  setupFirebaseCoreMocks();
}

// Common test widgets
Widget createTestableWidget(Widget child) {
  return MaterialApp(
    home: child,
  );
}

// Common test data
const testEmail = 'test@example.com';
const testPassword = 'password123';
const testUserName = 'Test User';
const testPhone = '12345678';
const testPlate = '1234TU123';

// Mock classes for Firebase Core
class MockFirebaseApp extends Mock implements FirebaseApp {}
class MockFirebaseOptions extends Mock implements FirebaseOptions {} 