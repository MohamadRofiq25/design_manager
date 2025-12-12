import 'package:flutter_test/flutter_test.dart';
import 'package:design_manager/presentation/manager/pages/profile/profile_controller.dart';


void main() {
  group('ProfileController Unit Test', () {
    late ProfileController controller;

    setUp(() {
      controller = ProfileController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Inisialisasi awal benar', () {
      expect(controller.isEditing, false);
      expect(controller.userData.value['name'], 'Mohamad Rofiq');
      expect(controller.userData.value['email'], 'rofiq@taskmanager.com');
      expect(controller.nameController.text, 'Mohamad Rofiq');
      expect(controller.emailController.text, 'rofiq@taskmanager.com');
    });

    test('toggleEditMode() mengubah nilai isEditing', () {
      // awalnya false
      expect(controller.isEditing, false);

      controller.toggleEditMode();
      expect(controller.isEditing, true);

      controller.toggleEditMode();
      expect(controller.isEditing, false);
    });

    test('saveProfile() menyimpan data baru', () {
      controller.nameController.text = 'Nama Baru';
      controller.emailController.text = 'email@baru.com';

      controller.saveProfile();

      expect(controller.userData.value['name'], 'Nama Baru');
      expect(controller.userData.value['email'], 'email@baru.com');

      // setelah save, mode edit harus OFF
      expect(controller.isEditing, false);
    });
  });
}
