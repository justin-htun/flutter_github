import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/repo_model.dart';
import '../providers/user_detail_provider.dart';

class UserDetailController extends GetxController {
  final UserDetailProvider userDetailProvider = UserDetailProvider();
  final ScrollController scrollController = ScrollController();

  var currentPage = 0.obs;
  final isRefreshing = false.obs;
  final isRepoLoading = true.obs;
  final isLoadMoreRepos = false.obs;
  final reachedMax = false.obs;
  var repoList = <Repo>[].obs;

  @override
  void onInit() {
    getAllRepos( userName: "mojombo",isLoading: false, isLoadMore: false);
    super.onInit();
  }

  Future<void> refreshUserDetailList() async {
    await Future.delayed(const Duration(seconds: 1));
    isRefreshing(true);
    currentPage.value = 0;
    await getAllRepos( userName: "mojombo",isLoading: false, isLoadMore: false);
    isRefreshing(false);
  }

  Future<void> getAllRepos({required String userName,bool isLoading = true, bool isLoadMore = false}) async {
    isRepoLoading(isLoading);
    isLoadMoreRepos(isLoadMore);
    userDetailProvider.getAllRepos(userName,currentPage.value).then((value) {
      if (isLoadMore) {
        for (var element in value) {
          repoList.add(element);
        }
      } else {
        repoList.value = value;
      }
      reachedMax.value = (value == []);
      isRepoLoading(false);
      isLoadMoreRepos(false);
    }).catchError((onError) {
      isRepoLoading(false);
      isLoadMoreRepos(false);
    });
  }
}
