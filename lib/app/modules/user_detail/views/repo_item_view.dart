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
    return Card(
        elevation: 0.5,
        child: SizedBox(
          height: 140,
          child: Column(
            children: [
              Text(
                '${repo.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${repo.url}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
