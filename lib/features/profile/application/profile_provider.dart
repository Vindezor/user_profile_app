import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_profile_app/features/profile/application/profile_notifier.dart';
import 'package:user_profile_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:user_profile_app/features/profile/data/models/profile_model.dart';
import 'package:user_profile_app/features/profile/data/repositories/profile_repository.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<ProfileModel>>(
  (ref) => ProfileNotifier(ProfileRepository(ProfileRemoteDataSource())),
);
