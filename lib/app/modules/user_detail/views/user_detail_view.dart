import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:github/app/modules/user_detail/views/repo_item_view.dart';
import 'package:github/app/modules/user_detail/views/user_detail_header_view.dart';
import '../controllers/user_detail_controller.dart';
import '../models/repo_model.dart';

class UserDetailView extends GetView<UserDetailController> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: const Text('User Detail View'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: controller.refreshUserDetailList,
        child: controller.isRepoLoading.value
            ? const Center(
          child: CircularProgressIndicator.adaptive(),
        )
            : NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoadMoreRepos.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                controller.scrollController.position
                    .userScrollDirection ==
                    ScrollDirection.reverse &&
                !controller.reachedMax.value) {
              // start loading data
              controller.currentPage.value += 1;
              controller.getAllRepos(
                  isLoading: false, isLoadMore: true, userName: 'mojombo');
            }
            if (!controller.isRefreshing.value &&
                controller.scrollController.position
                    .userScrollDirection ==
                    ScrollDirection.forward &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.minScrollExtent) {
              _refreshIndicatorKey.currentState?.show();
            }
            return true;
          },
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            controller: controller.scrollController,
            child: Column(
              children: [
                UserDetailHeader(userDetail: controller.userDetailData.value,),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.repoList.length,
                    itemBuilder: (context, index) {
                      return RepoItem(
                        repo:  controller.repoList[index],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
          visible: controller.isLoadMoreRepos.value,
          child: const LinearProgressIndicator()),));
  }
}
