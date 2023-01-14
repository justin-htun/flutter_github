import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserListItem extends StatelessWidget {
  const UserListItem(
      {Key? key,
        this.onTap,
        required this.heroTag,
        required this.user,})
      : super(key: key);

  final Function()? onTap;
  final User user;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 0.5,
          child: SizedBox(
            height: 140,
            child: Row(
              children: [
                Hero(
                  tag: heroTag,
                  child: SizedBox(
                      height: 120,
                      width: 120,
                      child: user.avatarUrl != null? Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        child: Image.network(
                          user.avatarUrl!,
                        ),
                      )
                          : const Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                        size: 80,
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${user.login}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
