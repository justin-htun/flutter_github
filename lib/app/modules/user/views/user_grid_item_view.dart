import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/common_image_view.dart';
import '../models/user_model.dart';

class UserGridItem extends StatelessWidget {
  const UserGridItem(
      {Key? key,
        this.onTap,
        required this.user})
      : super(key: key);

  final Function()? onTap;
  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0.5,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: user.avatarUrl != null ? ImageView(
                  url: user.avatarUrl!,
                  fit: BoxFit.cover,
                  width: 80.0,
                  height: 80.0,
                  radius: 20,
                )
                    : const Icon(
                  Icons.camera_alt,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
              Column(
                children: [
                  Text(
                    '#${user.login}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    '${user.url}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
