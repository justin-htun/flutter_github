import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String avatarUrl;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late String htmlUrl;

  @HiveField(4)
  late bool favourite;
}