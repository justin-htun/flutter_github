import 'package:flutter/material.dart';
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
                    '${userDetail.name}',
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
        const SizedBox(height: 10,),
        Row  (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person_rounded, color: Colors.black54,),
            const SizedBox(width: 10,),

            Text(
              '${NumberFormat.compact().format(userDetail.followers)} followers',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text (
                '.',
              ),
            ),            Text(
              '${NumberFormat.compact().format(userDetail.following)} following',
            )
          ],
        ),
        Row  (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person_rounded, color: Colors.black54,),
            const SizedBox(width: 10,),
            Text(
              '${NumberFormat.compact().format(userDetail.publicRepos)} Repositories',
            ),
          ],
        ),
        Row  (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person_rounded, color: Colors.black54,),
            const SizedBox(width: 10,),
            Text(
              '${NumberFormat.compact().format(userDetail.publicGists)} Stars',
            ),
          ],
        ),
        const SizedBox(height: 15,),
        userInfoItem(Icons.location_city, "${userDetail.company}"),
        userInfoItem(Icons.location_on_outlined, "${userDetail.location}"),
        userInfoItem(Icons.mail_outline_sharp, "${userDetail.email}"),
        userInfoItem(Icons.save_as_sharp, "${userDetail.blog}"),
        userInfoItem(Icons.soap, "@${userDetail.twitterUsername}"),
      ],
    );
  }

  Widget userInfoItem(IconData iconData, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row  (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, color: Colors.black54,),
          const SizedBox(width: 10,),
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
