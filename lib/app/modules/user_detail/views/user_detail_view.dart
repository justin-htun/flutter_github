import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:github/app/modules/user_detail/views/repo_item_view.dart';
import 'package:github/app/modules/user_detail/views/user_detail_header_view.dart';
import '../controllers/user_detail_controller.dart';

class UserDetailView extends GetView<UserDetailController> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
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
                  isLoading: false, isLoadMore: true, userLogin: controller.userLogin.value);
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
            padding: const EdgeInsets.only(top: 10,left: 15, right: 15),
            physics: const ScrollPhysics(),
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDetailHeader(userDetail: controller.userDetailData.value,),
                const SizedBox(height: 20,),
                const Text(
                  'Repositories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 15,),
                ListView.separated(
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(),
                    ),
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
