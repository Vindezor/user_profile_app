import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';
import '../models/job_title_model.dart';

class ProfileRemoteDataSource {
  final _apiKey = '6c251f20';

  Future<ProfileModel> fetchProfile() async {
    final url = Uri.parse('https://my.api.mockaroo.com/current-user.json?key=$_apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar datos de perfil');
    }
  }

  Future<List<JobTitleModel>> fetchJobTitles() async {
    final url = Uri.parse('https://my.api.mockaroo.com/job-titles.json?key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => JobTitleModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar puestos de trabajo');
    }
  }
}
