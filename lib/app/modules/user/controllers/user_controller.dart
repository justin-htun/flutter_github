import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserController extends GetxController {
  final UserProvider userProvider = UserProvider();

  final ScrollController scrollController = ScrollController();
  final reachedMax = false.obs;

  var currentPage = 0.obs;
  final isRefreshing = false.obs;
  final isUserLoading = true.obs;
  final isLoadMoreUsers = false.obs;
  final isGridView = false.obs;
  var userList = <User>[].obs;

  @override
  void onInit() {
    getAllUsers();
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
    userProvider.getAllUsers(currentPage.value).then((value) {
      if (isLoadMore) {
        for (var element in value) {
          userList.add(element);
        }
      } else {
        userList.value = value;
      }
      reachedMax.value = (value == []);
      isUserLoading(false);
      isLoadMoreUsers(false);
    }).catchError((onError) {
      isUserLoading(false);
      isLoadMoreUsers(false);
    });
  }
}
