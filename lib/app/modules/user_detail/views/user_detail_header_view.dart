import 'package:flutter/material.dart';

import '../models/user_detail_model.dart';

class UserDetailHeader extends StatelessWidget {
  const UserDetailHeader(
      {Key? key, required this.userDetail,})
      : super(key: key);

  final UserDetail userDetail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Row(
        children: [
          SizedBox(
              height: 120,
              width: 120,
              child: userDetail.avatarUrl != null? Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10),
                child: Image.network(
                  userDetail.avatarUrl!,
                ),
              )
                  : const Icon(
                Icons.camera_alt,
                color: Colors.grey,
                size: 80,
              )),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${userDetail.login}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
