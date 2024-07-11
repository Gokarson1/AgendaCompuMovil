// access_model.dart
class AccessModel {
  final String email;
  final String userAgent;
  final DateTime created;

  AccessModel({
    required this.email,
    required this.userAgent,
    required this.created,
  });

  factory AccessModel.fromJson(Map<String, dynamic> json) {
    return AccessModel(
      email: json['email'],
      userAgent: json['userAgent'],
      created: DateTime.parse(json['created']),
    );
  }
}
