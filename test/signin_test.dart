import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' hide MockUser;
import 'package:flutter_application_1/signin.dart';
import 'package:mockito/mockito.dart';
import 'test_helper.dart';
import 'test_helper.mocks.dart';

void main() {
  late GeneratedMockFirebaseAuth mockAuth;

  setUp(() {
    mockAuth = GeneratedMockFirebaseAuth();
  });

  testWidgets('Sign in form validation', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(SignIn()));

    // Verify initial state
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // Email and password fields

    // Test empty email validation
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Test invalid email format
    await tester.enterText(find.byType(TextField).first, 'invalid-email');
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Test valid email but empty password
    await tester.enterText(find.byType(TextField).first, testEmail);
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Test valid credentials
    await tester.enterText(find.byType(TextField).first, testEmail);
    await tester.enterText(find.byType(TextField).last, testPassword);
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Verify navigation to home page after successful login
    final mockUser = GeneratedMockUser();
    when(mockUser.email).thenReturn(testEmail);
    when(mockUser.uid).thenReturn('test-uid');
    when(mockAuth.currentUser).thenReturn(mockUser);
  });

  testWidgets('Navigation to sign up', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(SignIn()));

    // Verify initial state
    expect(find.text('Sign up'), findsOneWidget);

    // Test navigation to sign up
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
  });

  testWidgets('Forgot password functionality', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(SignIn()));

    // Enter email for password reset
    await tester.enterText(find.byType(TextField).first, testEmail);

    // Tap forgot password button
    await tester.tap(find.text('Forget your Password'));
    await tester.pump();

    // Verify password reset functionality
    verify(mockAuth.sendPasswordResetEmail(email: testEmail)).called(1);
  });
} 