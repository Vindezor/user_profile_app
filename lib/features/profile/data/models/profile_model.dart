import 'package:user_profile_app/features/profile/data/models/job_title_model.dart';

class ProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final JobTitleModel jobTitle;
  final String photo;
  final String? localImagePath;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.jobTitle,
    required this.photo,
    this.localImagePath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      jobTitle: json['job_title'] != null
        ? JobTitleModel.fromJson(json['job_title'])
        : JobTitleModel.empty(),
      photo: json['photo'] ?? '',
    );
  }

  ProfileModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    JobTitleModel? jobTitle,
    String? photo,
    String? localImagePath,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      jobTitle: jobTitle ?? this.jobTitle,
      photo: photo ?? this.photo,
      localImagePath: localImagePath ?? this.localImagePath
    );
  }
}
