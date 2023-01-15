import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: SizedBox(
        width: 120,
        height: 120,
        child: Card(
          elevation: 0.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      color: Colors.white,
                      child: Center(
                        child: user.avatarUrl != null ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10),
                          child: Image.network(
                            user.avatarUrl!,
                          ),
                        )
                            : const Icon(
                          Icons.camera_alt,
                          size: 80,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Column(
                  children: [
                    Text(
                      '${user.login}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${user.login}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
