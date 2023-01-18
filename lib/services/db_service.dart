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

  Future addUser(User user) async {
    Hive.box<User>(user_list_box).add(user);
  }

  // Future updateUser(User user) async {
  //   user.save();
  // }

  Future update(List<User> userList) async {
    Hive.box<User>(user_list_box).clear();
    Hive.box<User>(user_list_box).addAll(userList);
  }

  List<User> getAllUsers() {
    return Hive.box<User>(user_list_box).values.toList().cast<User>();
  }

  Future deleteAllUsers () async{
    Hive.box<User>(user_list_box).clear();
  }
}