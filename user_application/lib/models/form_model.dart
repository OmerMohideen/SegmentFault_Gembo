class FormModel {
  final Map<String, String?> fields;
  final Map<String, String?> fileUrls;

  FormModel({required this.fields, required this.fileUrls});

  Map<String, dynamic> toJson() {
    return {
      'fields': fields,
      'fileUrls': fileUrls,
    };
  }

  FormModel.fromJson(Map<String, dynamic> data)
      : this(
          fields: Map<String, String?>.from(data['fields']),
          fileUrls: Map<String, String?>.from(data['fileUrls']),
        );
}
