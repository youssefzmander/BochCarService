import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' hide MockUser;
import 'package:flutter_application_1/mainHome.dart';
import 'package:mockito/mockito.dart';
import 'test_helper.dart';
import 'test_helper.mocks.dart';

void main() {
  late GeneratedMockFirebaseAuth mockAuth;

  setUp(() {
    mockAuth = GeneratedMockFirebaseAuth();
  });

  testWidgets('Main home navigation', (WidgetTester tester) async {
    // Set up mock user
    final mockUser = GeneratedMockUser();
    when(mockUser.email).thenReturn(testEmail);
    when(mockUser.uid).thenReturn('test-uid');
    when(mockAuth.currentUser).thenReturn(mockUser);

    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(BottomNavigation()));

    // Verify initial state
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.history), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    // Test navigation to history
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Test navigation to profile
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Test navigation back to home
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('Logout functionality', (WidgetTester tester) async {
    // Set up mock user
    final mockUser = GeneratedMockUser();
    when(mockUser.email).thenReturn(testEmail);
    when(mockUser.uid).thenReturn('test-uid');
    when(mockAuth.currentUser).thenReturn(mockUser);

    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(BottomNavigation()));

    // Test logout dialog
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();
    expect(find.text('Deconection'), findsOneWidget);
    expect(find.text('Confirmer la deconection'), findsOneWidget);

    // Test cancel logout
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Test confirm logout
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify sign out was called
    verify(mockAuth.signOut()).called(1);
  });
} 