import 'package:flutter/material.dart';

import '../models/repo_model.dart';

class RepoItem extends StatelessWidget {
  const RepoItem(
      {Key? key,
        required this.repo,})
      : super(key: key);
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${repo.name}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7,),
          SelectableText(
            '${repo.htmlUrl}',
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          )
        ],
      ),
    );
  }
}
