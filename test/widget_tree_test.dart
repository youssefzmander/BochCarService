import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' hide MockUser;
import 'package:flutter_application_1/WidgetTree.dart';
import 'package:flutter_application_1/signin.dart';
import 'package:flutter_application_1/mainHome.dart';
import 'package:mockito/mockito.dart';
import 'test_helper.dart';
import 'test_helper.mocks.dart';

void main() {
  late GeneratedMockFirebaseAuth mockAuth;

  setUp(() async {
    await setupFirebaseForTesting();
    mockAuth = GeneratedMockFirebaseAuth();
  });

  testWidgets('Widget tree shows sign in when not authenticated', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(WidgetTree()));

    // Verify that SignIn widget is shown when not authenticated
    expect(find.byType(SignIn), findsOneWidget);
    expect(find.byType(BottomNavigation), findsNothing);
  });

  testWidgets('Widget tree shows main home when authenticated', (WidgetTester tester) async {
    // Set up authenticated user
    final mockUser = GeneratedMockUser();
    when(mockUser.uid).thenReturn('test-uid');
    when(mockUser.email).thenReturn(testEmail);
    when(mockAuth.currentUser).thenReturn(mockUser);

    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(WidgetTree()));

    // Verify that BottomNavigation widget is shown when authenticated
    expect(find.byType(BottomNavigation), findsOneWidget);
    expect(find.byType(SignIn), findsNothing);
  });

  testWidgets('Widget tree updates on auth state change', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(createTestableWidget(WidgetTree()));

    // Initially should show SignIn
    expect(find.byType(SignIn), findsOneWidget);
    expect(find.byType(BottomNavigation), findsNothing);

    // Simulate user signing in
    final mockUser = GeneratedMockUser();
    when(mockUser.uid).thenReturn('test-uid');
    when(mockUser.email).thenReturn(testEmail);
    when(mockAuth.currentUser).thenReturn(mockUser);
    await tester.pump();

    // Should now show BottomNavigation
    expect(find.byType(BottomNavigation), findsOneWidget);
    expect(find.byType(SignIn), findsNothing);

    // Simulate user signing out
    when(mockAuth.currentUser).thenReturn(null);
    await tester.pump();

    // Should show SignIn again
    expect(find.byType(SignIn), findsOneWidget);
    expect(find.byType(BottomNavigation), findsNothing);
  });
} 