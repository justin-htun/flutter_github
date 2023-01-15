import 'dart:developer';
import 'package:github/config/api_config.dart';
import '../../../../services/dio_service.dart';
import '../models/repo_model.dart';
import '../models/user_detail_model.dart';

class UserDetailProvider {

  Future<UserDetail> fetchUserDetailData(String userLogin) async {
    UserDetail userDetailData = UserDetail();
    try {
      var response = await DIOService.createDio().get("/users/$userLogin");
      if (response.statusCode == 200) {
        var data = response.data;
        userDetailData = UserDetail.fromJson(data);
      } else {
        throw Exception("API responseCode is not 200");
      }
    } catch (error) {
      throw Exception(error);
    }
    return userDetailData;
  }

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
