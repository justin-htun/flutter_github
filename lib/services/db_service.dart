import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../app/modules/user/models/user.dart';
import '../app/modules/user/models/user_model.dart';

class AppDatabase {
  static const user_list_box = "USER_LIST_BOX";

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>(user_list_box);
  }

  Future<List<User>> update(List<User> userList) async {
    await Hive.box<User>(user_list_box).clear();
    await Hive.box<User>(user_list_box).addAll(userList);
    return Hive.box<User>(user_list_box).values.toList();
  }

  List<User> getAllUsers() {
    return Hive.box<User>(user_list_box).values.toList();
  }
}