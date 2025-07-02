import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/localStorage.dart';
import 'test_helper.dart';

void main() {
  late LStorage lStorage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    lStorage = LStorage();
  });

  group('Local Storage Tests', () {
    test('Add and retrieve data', () async {
      // Test data
      final testData = {
        'UserName': testUserName,
        'Email': testEmail,
        'Tel': testPhone,
        'Plate': testPlate,
      };

      // Add data
      await lStorage.addToLocalStorage('userData', testData.toString());
      
      // Retrieve data
      final retrievedData = await lStorage.getStoredData('userData');
      
      // Verify data
      expect(retrievedData, isNotNull);
      expect(retrievedData.toString(), equals(testData.toString()));
    });

    test('Update existing data', () async {
      // Initial data
      final initialData = {
        'UserName': testUserName,
        'Email': testEmail,
      };

      // Updated data
      final updatedData = {
        'UserName': 'Updated Name',
        'Email': 'updated@email.com',
      };

      // Add initial data
      await lStorage.addToLocalStorage('userData', initialData.toString());
      
      // Update data
      await lStorage.addToLocalStorage('userData', updatedData.toString());
      
      // Retrieve updated data
      final retrievedData = await lStorage.getStoredData('userData');
      
      // Verify data is updated
      expect(retrievedData.toString(), equals(updatedData.toString()));
    });

    test('Handle non-existent data', () async {
      // Try to retrieve non-existent data
      final retrievedData = await lStorage.getStoredData('nonExistentKey');
      
      // Verify data is null
      expect(retrievedData, isNull);
    });
  });
} 