import 'dart:developer';
import 'package:github/config/api_config.dart';
import '../../../../services/dio_service.dart';
import '../models/repo_model.dart';

class UserDetailProvider {
  Future<List<Repo>> getAllRepos(String userName, int page) async {
    List<Repo> repoList = [];
    try {
      var response = await DIOService.createDio().get("/users/$userName/repos?per_page=${ApiConfig.perPage}&page=$page");
      if (response.statusCode == 200) {
        var data = response.data;
        repoList = List.from(data??{}).map((e)=>Repo.fromJson(e)).toList();
      }
    } catch (error) {
      log('error => $error');
    }
    return repoList;
  }
}
