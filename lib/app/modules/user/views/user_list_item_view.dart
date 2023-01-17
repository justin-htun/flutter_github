import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_share/social_share.dart';

import '../../../widgets/common_image_view.dart';
import '../models/user_model.dart';

class UserListItem extends StatelessWidget {
  const UserListItem(
      {Key? key,
        this.onTap,
        required this.user,})
      : super(key: key);

  final Function()? onTap;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user.avatarUrl != null? ImageView(
                url: user.avatarUrl!,
                fit: BoxFit.cover,
                width: 80.0,
                height: 80.0,
                radius: 100,
              )
                  : const Icon(
                Icons.camera_alt,
                color: Colors.grey,
                size: 80,
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '#${user.login}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell (
                          onTap: () {
                            SocialShare.shareOptions(user.htmlUrl??"");
                          },
                          child: const Icon(
                            FontAwesomeIcons.shareFromSquare,
                            color: Colors.blueGrey,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectableText(
                      '${user.htmlUrl}',
                      style: const TextStyle(color: Colors.black54, fontSize: 13),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
