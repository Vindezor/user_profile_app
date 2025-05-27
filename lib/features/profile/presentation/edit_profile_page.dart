import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_profile_app/core/theme/app_styles.dart';
import 'package:user_profile_app/core/theme/button_styles.dart';
import 'package:user_profile_app/features/profile/application/job_title_provider.dart';
import 'package:user_profile_app/features/profile/application/profile_provider.dart';
import 'package:user_profile_app/features/profile/data/models/job_title_model.dart';
import 'package:user_profile_app/features/profile/data/models/profile_model.dart';
import 'package:user_profile_app/features/profile/presentation/widgets/editable_avatar.dart';
import 'package:user_profile_app/features/profile/presentation/widgets/job_title_dropdown.dart';
import 'package:user_profile_app/features/profile/presentation/widgets/labeled_text_field.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  JobTitleModel? selectedJobTitle;
  bool hasChanges = false;
  bool _initialized = false;
  bool isSaving = false;

  File? newImageFile;

  final ImagePicker _picker = ImagePicker();

  void _initControllers(ProfileModel profile, List<JobTitleModel> jobTitles) {
    nameController = TextEditingController(text: profile.firstName);
    lastNameController = TextEditingController(text: profile.lastName);
    emailController = TextEditingController(text: profile.email);

    selectedJobTitle = jobTitles.firstWhere(
      (job) => job.id == profile.jobTitle.id,
      orElse: () => jobTitles.first,
    );

    nameController.addListener(() => checkForChanges(profile));
    lastNameController.addListener(() => checkForChanges(profile));
    _initialized = true;
  }

  void checkForChanges(ProfileModel profile) {
    final changed = nameController.text != profile.firstName ||
        lastNameController.text != profile.lastName ||
        selectedJobTitle?.id != profile.jobTitle.id ||
        newImageFile != null;

    if (changed != hasChanges) {
      setState(() {
        hasChanges = changed;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        newImageFile = File(image.path);
        hasChanges = true;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);
    final jobTitlesAsync = ref.watch(jobTitlesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Editar Perfil")),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error al cargar perfil: $e")),
        data: (profile) {
          return jobTitlesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Error al cargar puestos: $e")),
            data: (jobTitles) {
              if (!_initialized) {
                _initControllers(profile, jobTitles);
              }

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: EditableAvatar(
                          imageUrl: profile.photo,
                          newImageFile: newImageFile,
                          localPath: profile.localImagePath,
                          onEdit: _pickImage
                        ),
                      ),
                      const SizedBox(height: 30),
                      LabeledTextField(
                        controller: nameController,
                        label: "Nombre",
                        requiredMessage: "El nombre es requerido",
                      ),
                      const SizedBox(height: 20),
                      LabeledTextField(
                        controller: lastNameController,
                        label: "Apellido",
                        requiredMessage: "El apellido es requerido",
                      ),
                      const SizedBox(height: 20),
                      JobTitleDropdown(
                        selected: selectedJobTitle, 
                        items: jobTitles,
                        onChanged: (value) {
                          setState(() {
                            selectedJobTitle = value;
                            checkForChanges(profile);
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Correo electrónico",
                          border: AppStyles.inputBorder
                        ),
                      ),
                      const SizedBox(height: 30),
                      isSaving
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            style: ButtonStyles.primaryRounded(context),
                            onPressed: hasChanges ? () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isSaving = true;
                                });

                                try {
                                  await Future.delayed(
                                    const Duration(seconds: 2)
                                  );
                                  ref.read(profileProvider.notifier)
                                    .updateProfile(
                                      name: nameController.text,
                                      lastName: lastNameController.text,
                                      jobTitle: selectedJobTitle,
                                      localImagePath: newImageFile?.path,
                                    );

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            "Cambios guardados con éxito"),
                                        behavior:
                                            SnackBarBehavior.floating,
                                        dismissDirection:
                                            DismissDirection.up,
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).size.height - 100,
                                          right: 20,
                                          left: 20,
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Error al guardar: $e"
                                        )
                                      ),
                                    );
                                  }
                                } finally {
                                  if (context.mounted) {
                                    setState(() {
                                      isSaving = false;
                                    });
                                  }
                                }
                              }
                            }
                            : null,
                            child: Text(
                              "Guardar cambios",
                              style: TextStyle(
                                color: hasChanges
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                    : null,
                                fontSize: 16,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
