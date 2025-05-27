import 'package:user_profile_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:user_profile_app/features/profile/data/models/job_title_model.dart';
import 'package:user_profile_app/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepository(this.remoteDataSource);

  Future<ProfileModel> getCurrentUser() async {
    final ProfileModel model = await remoteDataSource.fetchProfile();
    return model;
  }

  Future<List<JobTitleModel>> getJobTitles() async {
    final models = await remoteDataSource.fetchJobTitles();
    return models;
  }
}
