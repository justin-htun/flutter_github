import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../widgets/common_image_view.dart';
import '../models/user_detail_model.dart';

class UserDetailHeader extends StatelessWidget {
  const UserDetailHeader({
    Key? key,
    required this.userDetail,
  }) : super(key: key);

  final UserDetail userDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userDetail.avatarUrl != null
                ? ImageView(
                    url: userDetail.avatarUrl!,
                    fit: BoxFit.contain,
                    width: 100.0,
                    height: 100.0,
                    radius: 0,
                  )
                : const Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                    size: 80,
                  ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userDetail.name??"GitHub user",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '#${userDetail.login}',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    '${userDetail.htmlUrl}',
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.userGroup,
              color: Colors.black54,
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                  text:
                      NumberFormat.compact().format(userDetail.followers ?? 0),
                  style: const TextStyle(color: Colors.black),
                  children: const [
                    TextSpan(
                      text: " followers",
                      style: TextStyle(color: Colors.black54),
                    )
                  ]),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '.',
              ),
            ),
            RichText(
              text: TextSpan(
                  text: NumberFormat.compact().format(userDetail.following??0),
                  style: const TextStyle(color: Colors.black),
                  children: const [
                    TextSpan(
                      text: " following",
                      style: TextStyle( color: Colors.black54),)
                  ]),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.bookBookmark,
                color: Colors.black54, size: 18),
            const SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                  text: NumberFormat.compact().format(userDetail.publicRepos??0),
                  style: const TextStyle(color: Colors.black),
                  children: const [
                    TextSpan(
                      text: " Repositories",
                      style: TextStyle( color: Colors.black54),)
                  ]),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.star, color: Colors.black54, size: 18),
            const SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                  text: NumberFormat.compact().format(userDetail.publicGists??0),
                  style: const TextStyle(color: Colors.black),
                  children: const [
                    TextSpan(
                      text: " Stars",
                      style: TextStyle( color: Colors.black54),)
                  ]),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        ListTileTheme(
          contentPadding: const EdgeInsets.all(0),
          child: ExpansionTile(
              title: const Text(
                'Contact info',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              children: <Widget>[
                Visibility(
                  visible: userDetail.company != null,
                  child: userInfoItem(
                      FontAwesomeIcons.building, "${userDetail.company}"),
                ),
                Visibility(
                  visible: userDetail.location != null,
                  child: userInfoItem(
                      FontAwesomeIcons.locationDot, "${userDetail.location}"),
                ),
                Visibility(
                    visible: userDetail.email != null,
                    child: userInfoItem(FontAwesomeIcons.envelope, "${userDetail.email}")),
                Visibility(
                    visible: userDetail.blog != null,
                    child: userInfoItem(FontAwesomeIcons.blog, "${userDetail.blog}")),
                Visibility(
                  visible: userDetail.twitterUsername != null,
                  child: userInfoItem(
                      FontAwesomeIcons.twitter, "@${userDetail.twitterUsername}"),
                ),
                const SizedBox(
                  height: 10,
                )
              ]),
        ),
      ],
    );
  }

  Widget userInfoItem(IconData iconData, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.black54,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SelectableText(
              info,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
