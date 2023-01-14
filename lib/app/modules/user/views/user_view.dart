import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:github/app/modules/user/views/user_grid_item_view.dart';
import 'package:github/app/modules/user/views/user_list_item_view.dart';
import 'package:github/config/api_config.dart';

import '../../../routes/app_pages.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class UserView extends GetView<UserController> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('UserView'),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: controller.refreshUserList,
            child: controller.isUserLoading.value
                ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
                : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isLoadMoreUsers.value &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    controller.scrollController.position
                        .userScrollDirection ==
                        ScrollDirection.reverse &&
                    !controller.reachedMax.value) {
                  // start loading data
                  controller.currentPage.value += 1;
                  controller.getAllUsers(
                      isLoading: false, isLoadMore: true);
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
              child: controller.isGridView.value
                  ? GridView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.userList.length,
                  gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    User user = controller.userList[index];
                    return UserGridItem(
                      heroTag: "gridTag$index",
                      user: user,
                      onTap: () => Get.toNamed(Routes.USER_DETAIL,
                          arguments: {
                            "heroTag": "gridTag$index",
                            "user": user,
                            "userName": user.login
                          }),
                    );
                  })
                  : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller.scrollController,
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    User user = controller.userList[index];
                    return UserListItem(
                      heroTag: "listTag$index",
                      user: user,
                      onTap: () => Get.toNamed(Routes.USER_DETAIL,
                          arguments: {
                            "heroTag": "listTag$index",
                            "user": user,
                            "userName": user.login
                          }),
                    );
                  }),
            ),
          ),
      floatingActionButton: Obx(() => FloatingActionButton(
        onPressed: () {
          controller.changeUserView();
        },
        child: Icon(controller.isGridView.value
            ? Icons.menu
            : Icons.grid_view_sharp),
      )),
      bottomNavigationBar: Visibility(
          visible: controller.isLoadMoreUsers.value,
          child: const LinearProgressIndicator()),));
  }
}