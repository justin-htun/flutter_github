import 'dart:developer';
import 'package:github/config/api_config.dart';
import '../../../../services/dio_service.dart';
import '../models/user_model.dart';

class UserProvider {
  Future<List<User>> getAllUsers(int page) async {
    List<User> userList = [];
    try {
      var response = await DIOService.createDio().get("/users?per_page=100&page=$page");  /*User list API "https://api.github.com/users?per_page=10&page=1" is not working properly. That is why, value is 100 for per_page :(.*/
      if (response.statusCode == 200) {
        var data = response.data;
        userList = List.from(data??{}).map((e)=>User.fromJson(e)).toList();
      }
    } catch (error) {
      log('error => $error');
      throw Exception(error);
    }
    return userList;
  }
}
