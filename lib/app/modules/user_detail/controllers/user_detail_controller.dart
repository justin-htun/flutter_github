import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/repo_model.dart';
import '../models/user_detail_model.dart';
import '../providers/user_detail_provider.dart';

class UserDetailController extends GetxController {
  final UserDetailProvider userDetailProvider = UserDetailProvider();
  final ScrollController scrollController = ScrollController();

  var currentPage = 0.obs;
  final isRefreshing = false.obs;
  final isInitialLoading = true.obs;
  final isLoadMoreRepos = false.obs;
  final reachedMax = false.obs;
  final userDetailData = UserDetail().obs;
  var repoList = <Repo>[].obs;
  var userLogin = "".obs;

  @override
  void onInit() {
    if(Get.arguments != null) {
      userLogin.value = Get.arguments["userLogin"];
      fetchUserDetailData(userLoginValue: userLogin.value);
    }
    super.onInit();
  }

  Future<void> refreshUserDetailList() async {
    await Future.delayed(const Duration(seconds: 1));
    isRefreshing(true);
    currentPage.value = 0;
    await fetchUserDetailData(userLoginValue: userLogin.value);
    isRefreshing(false);
  }

  Future<void> fetchUserDetailData({required String userLoginValue}) async {
    isInitialLoading(true);
    userDetailProvider
        .fetchUserDetailData(userLoginValue)
        .then(
          (value) async {
            userDetailData.value = value;
            isInitialLoading(false);
            getAllRepos( userLogin: userLogin.value,isLoading: false, isLoadMore: false);
          },
    ).catchError((error) {
      // AppUtil.showMessage(
      //     title: 'Error',
      //     message: "Fetch product detail data failed",
      //     alertType: AlertType.error);
      isInitialLoading(false);
    });
  }

  Future<void> getAllRepos({required String userLogin,bool isLoading = true, bool isLoadMore = false}) async {
    isLoadMoreRepos(isLoadMore);
    userDetailProvider.getAllRepos(userLogin,currentPage.value).then((value) {
      if (isLoadMore) {
        for (var element in value) {
          repoList.add(element);
        }
      } else {
        repoList.value = value;
      }
      reachedMax.value = (value == []);
      isLoadMoreRepos(false);
    }).catchError((onError) {
      isLoadMoreRepos(false);
    });
  }
}
