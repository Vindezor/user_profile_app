import 'package:flutter/material.dart';
import 'package:user_profile_app/features/profile/data/models/job_title_model.dart';

class JobTitleDropdown extends StatelessWidget {
  final JobTitleModel? selected;
  final List<JobTitleModel> items;
  final Function(JobTitleModel?) onChanged;

  const JobTitleDropdown({
    required this.selected,
    required this.items,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<JobTitleModel>(
      isExpanded: true,
      value: selected,
      items: items.map((title) {
        return DropdownMenuItem(
          value: title,
          child: Text(title.value),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: "Puesto de trabajo",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      onChanged: onChanged,
    );
  }
}