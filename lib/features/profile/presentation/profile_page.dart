import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_profile_app/core/theme/button_styles.dart';
import 'package:user_profile_app/features/profile/application/profile_provider.dart';
import 'package:user_profile_app/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:user_profile_app/features/profile/presentation/widgets/user_info_row.dart';
import 'package:user_profile_app/routes/routes.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        // backgroundColor: Colors.purple[50],
        appBar: AppBar(title: const Text("Perfil")),
        body: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error: $e")),
          data: (profile) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                ProfileAvatar(
                  imageUrl: profile.photo,
                  localPath: profile.localImagePath,
                ),

                const SizedBox(height: 20),
                Text(
                  "${profile.firstName} ${profile.lastName}",
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  profile.jobTitle.value,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                UserInfoRow(icon: Icons.email_outlined, text: profile.email),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.push(Routes.editProfile);
                    },
                    icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.onPrimary, size: 20,),
                    label: Text(
                      "Editar Perfil",
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                    ),
                    style: ButtonStyles.primaryRounded(context),
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
