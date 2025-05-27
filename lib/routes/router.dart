// lib/routes/router.dart
import 'package:go_router/go_router.dart';
import 'package:user_profile_app/features/profile/presentation/edit_profile_page.dart';
import 'package:user_profile_app/features/profile/presentation/profile_page.dart';
import 'package:user_profile_app/routes/routes.dart';

final router = GoRouter(
  initialLocation: Routes.profile,
  routes: [
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: Routes.editProfile,
      builder: (context, state) => const EditProfilePage(),
    ),
  ],
);
