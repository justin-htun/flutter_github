import 'package:get/get.dart';
import '../../../../services/db_service.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await AppDatabase().initialize();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(Routes.USER);
    });
  }
}
