import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' hide MockUser;
import 'package:flutter_application_1/profile.dart';
import 'package:mockito/mockito.dart';
import 'test_helper.dart';
import 'test_helper.mocks.dart';

void main() {
  late GeneratedMockFirebaseAuth mockAuth;

  setUp(() {
    mockAuth = GeneratedMockFirebaseAuth();
  });

  testWidgets('Profile form validation', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(Profile()));

    // Verify initial state
    expect(find.byType(TextField), findsNWidgets(5)); // All input fields

    // Test name field
    await tester.enterText(find.byType(TextField).first, testUserName);
    await tester.pump();
    expect(find.text(testUserName), findsOneWidget);

    // Test email field
    await tester.enterText(find.byType(TextField).at(1), testEmail);
    await tester.pump();
    expect(find.text(testEmail), findsOneWidget);

    // Test phone field
    await tester.enterText(find.byType(TextField).at(2), testPhone);
    await tester.pump();
    expect(find.text(testPhone), findsOneWidget);

    // Test plate number fields
    await tester.enterText(find.byType(TextField).at(3), '1234');
    await tester.pump();
    expect(find.text('1234'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(4), '123');
    await tester.pump();
    expect(find.text('123'), findsOneWidget);
  });

  testWidgets('Password change functionality', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(Profile()));

    // Set up mock user
    final mockUser = GeneratedMockUser();
    when(mockUser.email).thenReturn(testEmail);
    when(mockUser.uid).thenReturn('test-uid');
    when(mockAuth.currentUser).thenReturn(mockUser);

    // Test password change form
    await tester.enterText(find.byType(TextField).at(5), testPassword); // Old password
    await tester.enterText(find.byType(TextField).at(6), 'newPassword123'); // New password
    await tester.enterText(find.byType(TextField).at(7), 'newPassword123'); // Confirm password
    await tester.pump();

    // Test update button
    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    // Verify password update
    verify(mockUser.updatePassword('newPassword123')).called(1);
  });

  testWidgets('MatType dropdown', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(Profile()));

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
} 