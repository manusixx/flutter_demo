import 'dart:async';
import '../repository/student_api_service.dart';
import '../model/student_model.dart';

class StudentBloc {
  final StudentRepository _repository = StudentRepository();

  // StreamController para lista de estudiantes esta escuchando siempre si hay cambios
  final _studentListController = StreamController<List<StudentModel>>.broadcast();
  // StreamController para un solo estudiante
  final _studentController = StreamController<StudentModel>();
  // StreamController para mensajes de estado/error
  final _messageController = StreamController<String>();

  List<StudentModel> _studentList = [];

  // Streams públicos
  Stream<List<StudentModel>> get studentListStream => _studentListController.stream;
  Stream<StudentModel> get studentStream => _studentController.stream;
  Stream<String> get messageStream => _messageController.stream;

  // Carga todos los estudiantes
  Future<void> loadStudents() async {
    try {
      _studentList = await _repository.getAllStudents();
      _studentListController.sink.add(_studentList);
    } catch (e) {
      _messageController.sink.add('Error cargando estudiantes: $e');
    }
  }

  // Carga un estudiante por id
  Future<void> loadStudentById(int id) async {
    try {
      final student = await _repository.getStudentById(id);
      _studentController.sink.add(student);
    } catch (e) {
      _messageController.sink.add('Error cargando estudiante: $e');
    }
  }

  // Crear estudiante
  Future<void> createStudent(StudentModel student) async {
    try {
      await _repository.createStudent(student);
      _messageController.sink.add("Estudiante creado correctamente");
      await loadStudents();
    } catch (e) {
      _messageController.sink.add('Error creando estudiante: $e');
    }
  }

  // Actualizar estudiante
  Future<void> updateStudent(StudentModel student) async {
    try {
      await _repository.updateStudent(student);
      _messageController.sink.add("Estudiante actualizado correctamente");
      await loadStudents();
    } catch (e) {
      _messageController.sink.add('Error actualizando estudiante: $e');
    }
  }

  // Eliminar estudiante
  Future<void> deleteStudent(int id) async {
    try {
      await _repository.deleteStudent(id);
      _messageController.sink.add("Estudiante eliminado correctamente");
      await loadStudents();
    } catch (e) {
      _messageController.sink.add('Error eliminando estudiante: $e');
    }
  }

  // Cierra todos los streams, llamar en dispose del widget
  void dispose() {
    _studentListController.close();
    _studentController.close();
    _messageController.close();
  }
}
