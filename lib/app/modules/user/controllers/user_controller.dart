
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/db_service.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class UserController extends GetxController {
  final UserProvider userProvider = UserProvider();
  final searchTextController = TextEditingController();

  final ScrollController scrollController = ScrollController();
  final reachedMax = false.obs;

  var currentPage = 0.obs;
  final isRefreshing = false.obs;
  final isUserLoading = true.obs;
  final isLoadMoreUsers = false.obs;
  final isGridView = false.obs;
  var userList = <User>[].obs;
  List<User> userListAlias = [];

  @override
  Future<void> onInit() async {
    getAllUsers();
    searchTextController.addListener((){
      List<User> filteredList = userListAlias.where((user) => user.name.toLowerCase().contains(searchTextController.text.toLowerCase())).toList();
      userList.value = filteredList;
    });
    super.onInit();
  }

  void changeUserView() => isGridView.value = !isGridView.value;

  Future<void> refreshUserList() async {
    await Future.delayed(const Duration(seconds: 1));
    isRefreshing(true);
    currentPage.value = 0;
    await getAllUsers(isLoading: false, isLoadMore: false);
    isRefreshing(false);
  }

  Future<void> getAllUsers({bool isLoading = true, bool isLoadMore = false}) async {
    isUserLoading(isLoading);
    isLoadMoreUsers(isLoadMore);
    userProvider.getAllUsers(currentPage.value).then((value) async {
      List<User> oldDbData = AppDatabase().getAllUsers();
      List<User> tempUserList = [];
      for (var element in value) {
        final user = User()
          ..id = element.id??0
          ..avatarUrl = element.avatarUrl??""
          ..name = element.login??""
          ..htmlUrl = element.htmlUrl??""
          ..favourite = false;
        user.favourite = oldDbData.firstWhere((element) => element.id == user.id,orElse: () {
          return User()..favourite= false;
        }).favourite;
        tempUserList.add(user);
      }
      reachedMax.value = (value == []);
      userList.value = await AppDatabase().updateAllUsers(tempUserList);
      userListAlias.clear();
      userListAlias.addAll(userList);
      isUserLoading(false);
      isLoadMoreUsers(false);
    }).catchError((onError) {
      userList.value =  AppDatabase().getAllUsers();
      userListAlias.clear();
      userListAlias.addAll(userList);
      reachedMax(true);
      isUserLoading(false);
      isLoadMoreUsers(false);
    });
  }

  Future changetFavoriteStatus (User user) async {
    user.favourite = !user.favourite;
    userList.value = await AppDatabase().updateAllUsers(userList);
    userListAlias.clear();
    userListAlias.addAll(userList);
  }
}
