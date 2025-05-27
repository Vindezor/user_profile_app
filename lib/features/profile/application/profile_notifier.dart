import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_profile_app/features/profile/data/models/job_title_model.dart';
import 'package:user_profile_app/features/profile/data/models/profile_model.dart';
import 'package:user_profile_app/features/profile/data/repositories/profile_repository.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const AsyncLoading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final profile = await _repository.getCurrentUser();
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

   void updateProfile({
    String? name,
    JobTitleModel? jobTitle,
    String? localImagePath,
  }) {
    state = state.whenData((profile) {
      return profile.copyWith(
        firstName: name,
        jobTitle: jobTitle,
        localImagePath: localImagePath ?? profile.localImagePath,
      );
    });
  }
}
