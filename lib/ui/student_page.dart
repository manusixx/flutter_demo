

import 'package:flutter/material.dart';
import '../bloc/student_bloc.dart';
import '../model/student_model.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final StudentBloc _studentBloc = StudentBloc();
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Cargar todos los estudiantes al inicio
    _studentBloc.loadStudents();
  }

  @override
  void dispose() {
    _studentBloc.dispose();
    _filterController.dispose();
    super.dispose();
  }

  void _filterStudents() {
    final idText = _filterController.text.trim();
    if (idText.isEmpty) {
      // Si vacio, recarga todos los estudiantes
      _studentBloc.loadStudents();
    } else {
      final id = int.tryParse(idText);
      if (id != null) {
        _studentBloc.loadStudentById(id);
      } else {
        // Mostrar mensaje error o ignorar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor ingrese un ID numérico válido')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Estudiantes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Campo de texto y botón para filtrar por ID
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _filterController,
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por ID',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _filterStudents(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _filterStudents,
                  child: const Text('Filtrar'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // StreamBuilder para mostrar la tabla con estudiantes
            Expanded(
              child: StreamBuilder<List<StudentModel>>(
                stream: _studentBloc.studentListStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay estudiantes para mostrar'));
                  }
                  final students = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Apellido')),
                        DataColumn(label: Text('Edad')),
                        DataColumn(label: Text('Estado')),
                      ],
                      rows: students.map((student) {
                        return DataRow(cells: [
                          DataCell(Text(student.id.toString())),
                          DataCell(Text(student.name)),
                          DataCell(Text(student.lastName)),
                          DataCell(Text(student.age.toString())),
                          DataCell(Text(student.state ? 'Activo' : 'Inactivo')),
                        ]);
                      }).toList(),
                    ),
                  );
                },
              ),
            ),

            // StreamBuilder para mensajes
            StreamBuilder<String>(
              stream: _studentBloc.messageStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      snapshot.data!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
