import 'package:get/get_state_manager/get_state_manager.dart';

class ThemeController extends GetxController {
  bool darkModeEnabled = false;

  toggleDarkMode() {
    darkModeEnabled = !darkModeEnabled;
    update();
  }
}
