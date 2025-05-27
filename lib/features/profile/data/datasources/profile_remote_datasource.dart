import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';
import '../models/job_title_model.dart';

class ProfileRemoteDataSource {
  final _apiKey = '6c251f20';

  Future<ProfileModel> fetchProfile() async {
    final url = Uri.parse('https://my.api.mockaroo.com/current-user.json?key=$_apiKey');
    final response = await http.get(url);
    log('Status code: ${response.statusCode}');
    log('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  Future<List<JobTitleModel>> fetchJobTitles() async {
    final url = Uri.parse('https://my.api.mockaroo.com/job-titles.json?key=$_apiKey');
    final response = await http.get(url);
    log('Status code: ${response.statusCode}');
    log('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => JobTitleModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch job titles');
    }
  }
}
