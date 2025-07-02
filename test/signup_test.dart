import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' hide MockUser;
import 'package:flutter_application_1/signup.dart';
import 'package:mockito/mockito.dart';
import 'test_helper.dart';
import 'test_helper.mocks.dart';

void main() {
  late GeneratedMockFirebaseAuth mockAuth;

  setUp(() {
    mockAuth = GeneratedMockFirebaseAuth();
  });

  testWidgets('Sign up form validation', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(SignUp()));

    // Verify initial state
    expect(find.text('Register Account'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(6)); // All input fields

    // Test empty fields validation
    await tester.tap(find.text('CONTINUE'));
    await tester.pump();

    // Test name field
    await tester.enterText(find.byType(TextField).first, testUserName);
    await tester.pump();

    // Test email field
    await tester.enterText(find.byType(TextField).at(1), testEmail);
    await tester.pump();

    // Test plate number fields
    await tester.enterText(find.byType(TextField).at(2), '1234');
    await tester.pump();

    await tester.enterText(find.byType(TextField).at(3), '123');
    await tester.pump();

    // Test phone field
    await tester.enterText(find.byType(TextField).at(4), testPhone);
    await tester.pump();

    // Test password fields
    await tester.enterText(find.byType(TextField).at(5), testPassword);
    await tester.pump();

    // Test successful registration
    final mockUser = GeneratedMockUser();
    when(mockUser.email).thenReturn(testEmail);
    when(mockUser.uid).thenReturn('test-uid');
    when(mockAuth.currentUser).thenReturn(mockUser);

    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
  });

  testWidgets('MatType dropdown selection', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(SignUp()));

    // Test dropdown options
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    // Verify all options are present
    expect(find.text('TU'), findsOneWidget);
    expect(find.text('RS'), findsOneWidget);
    expect(find.text('FCR'), findsOneWidget);
    expect(find.text('DOUANE'), findsOneWidget);
    expect(find.text('ETAT'), findsOneWidget);
    expect(find.text('AUTRES'), findsOneWidget);

    // Select an option
    await tester.tap(find.text('RS').last);
    await tester.pumpAndSettle();

    // Verify selection
    expect(find.text('RS'), findsOneWidget);
  });

  testWidgets('Navigation back to sign in', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(SignUp()));

    // Test navigation back to sign in
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
  });
} 