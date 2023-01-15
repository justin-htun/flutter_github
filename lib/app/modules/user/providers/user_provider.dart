import 'dart:developer';
import 'package:github/config/api_config.dart';
import '../../../../services/dio_service.dart';
import '../models/user_model.dart';

class UserProvider {
  Future<List<User>> getAllUsers(int page) async {
    List<User> userList = [];
    try {
      var response = await DIOService.createDio().get("/users?per_page=${ApiConfig.perPage}&page=$page");
      if (response.statusCode == 200) {
        var data = response.data;
        userList = List.from(data??{}).map((e)=>User.fromJson(e)).toList();
      }
    } catch (error) {
      log('error => $error');
    }
    return userList;
  }
}
