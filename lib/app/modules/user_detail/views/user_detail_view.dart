import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_detail_controller.dart';

class UserDetailView extends GetView<UserDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UserDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
