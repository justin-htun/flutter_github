import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_share/social_share.dart';

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
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0.5,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: ImageView(
                        url: user.avatarUrl??"",
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 80.0,
                        radius: 20,
                      )
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: InkWell (
                      onTap: () {
                        SocialShare.shareOptions(user.htmlUrl??"");
                      },
                      child: const Icon(
                        FontAwesomeIcons.shareFromSquare,
                        color: Colors.blueGrey,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '#${user.login}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SelectableText(
                '${user.htmlUrl}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
              Container()
            ]),
      ),
    );
  }
}
