import 'package:flutter/material.dart';

import '../controllers/user_controller.dart';

AppBar buildUserAppBar(UserController controller) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: 45,
      child: TextField(
        controller: controller.searchTextController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 23,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: 'Search users by name',
          hintStyle:
          const TextStyle( color: Colors.black54, fontSize: 12),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
        ),
      ),
    ),
  );
}
