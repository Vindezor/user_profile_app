import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_profile_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:user_profile_app/features/profile/data/models/job_title_model.dart';
import 'package:user_profile_app/features/profile/data/repositories/profile_repository.dart';

final jobTitlesProvider = FutureProvider<List<JobTitleModel>>((ref) {
  final repository = ProfileRepository(ProfileRemoteDataSource());
  return repository.getJobTitles();
});