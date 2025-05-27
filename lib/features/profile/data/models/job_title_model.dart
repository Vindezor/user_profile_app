class JobTitleModel {
  final String id;
  final String value;

  JobTitleModel({required this.id, required this.value});

  factory JobTitleModel.fromJson(Map<String, dynamic> json) {
    return JobTitleModel(
      id: json['id']?.toString() ?? '0',
      value: json['value'] ?? '',
    );
  }

  JobTitleModel.empty() : id = '0', value = '';
}
