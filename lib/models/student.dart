class Student {
  final String isSigaConfigured;
  final String user;
  final String rgSiga;
  final String sigaPassword;

  Student({this.isSigaConfigured, this.rgSiga, this.sigaPassword, this.user});

  Map<String, dynamic> toMap() {
    return {
      'isSigaConfigured': isSigaConfigured,
      'user': user,
      'rgSiga': rgSiga,
      'sigaPassword': sigaPassword,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      isSigaConfigured: json['isSigaConfigured'],
      user: json['user'],
      rgSiga: json['rgSiga'],
      sigaPassword: json['sigaPassword'],
    );
  }
}
