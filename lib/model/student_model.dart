class StudentModel {
  final int id;
  final String name;
  final String lastName;
  final int age;
  final bool state;

  StudentModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.age,
    required this.state,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as int,
      state: json['state'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age,
      'state': state,
    };
  }
}
