import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../app/modules/user/models/user_model.dart';

class AppDatabase {
  static const user_list_box = "USER_LIST_BOX";
  static const user_list_data_key = "USER_LIST_DATA_KEY";
  late final _usersBox;

  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal() {}

  Future<void> initialize() async {
    await Hive.initFlutter();
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox(user_list_box);
    _usersBox = Hive.box(user_list_box);
  }

  Future<void> deleteAllUsers() async {
    await _usersBox??Hive.box(user_list_box).clear();
  }

  Future<void> setUsers(List<User> userList) async {
    (_usersBox??=Hive.box(user_list_box)).put(user_list_data_key, jsonEncode(userList));
  }

  List<User> getAllUsers() {
    return  List.from(jsonDecode((_usersBox??=Hive.box(user_list_box)).get(user_list_data_key))??{}).map((d)=>User.fromJson(d)).toList();
  }
}