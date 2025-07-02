import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' hide MockUser;
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/signin.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'test_helper.dart';
import 'test_helper.mocks.dart';

void main() {
  late GeneratedMockFirebaseAuth mockAuth;
  late Auth auth;

  setUp(() {
    mockAuth = GeneratedMockFirebaseAuth();
    auth = Auth();
  });

  group('Authentication Tests', () {
    test('Sign in with email and password', () async {
      // Arrange
      final mockUser = GeneratedMockUser();
      when(mockUser.email).thenReturn(testEmail);
      when(mockUser.uid).thenReturn('test-uid');
      when(mockAuth.currentUser).thenReturn(mockUser);

      // Act
      await auth.signInWithEmailAndPassword(
        email: testEmail,
        password: testPassword,
      );

      // Assert
      expect(mockAuth.currentUser, isNotNull);
      expect(mockAuth.currentUser?.email, equals(testEmail));
    });

    test('Sign up with email and password', () async {
      // Arrange
      final mockUser = GeneratedMockUser();
      when(mockUser.email).thenReturn(testEmail);
      when(mockUser.uid).thenReturn('test-uid');
      when(mockAuth.currentUser).thenReturn(mockUser);

      // Act
      await auth.createUserWithEmailAndPassword(
        email: testEmail,
        password: testPassword,
      );

      // Assert
      expect(mockAuth.currentUser, isNotNull);
      expect(mockAuth.currentUser?.email, equals(testEmail));
    });

    test('Sign out', () async {
      // Arrange
      final mockUser = GeneratedMockUser();
      when(mockUser.email).thenReturn(testEmail);
      when(mockUser.uid).thenReturn('test-uid');
      when(mockAuth.currentUser).thenReturn(mockUser);

      // Act
      await auth.signOut();

      // Assert
      verify(mockAuth.signOut()).called(1);
    });
  });
} 