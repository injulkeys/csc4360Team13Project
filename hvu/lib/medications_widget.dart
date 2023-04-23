import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hvu/navbar.dart';
import 'package:hvu/profile_screen.dart';
import 'message_widget.dart';
import 'medications_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Medication {
  String title;
  String description;
  String dosage;
  String frequency;

  Medication({
    required this.title,
    required this.description,
    required this.dosage,
    required this.frequency,
  });
}

class MedicationList extends StatefulWidget {
  @override
  _MedicationListState createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  List<Medication> _medications = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Medication List'),
      ),
      body: ListView.builder(
        itemCount: _medications.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_medications[index].title),
            subtitle: Text(
                'Dosage: ${_medications[index].dosage}\nFrequency: ${_medications[index].frequency}'),
            trailing: TextButton(
              onPressed: () {
                _medications.removeAt(index);
                setState(() {});
              },
              child: Text('Fill Request'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _showAddDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(16.0),
            content: Column(
              children: <Widget>[
               const Text('Add Medication'),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  controller: titleController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  controller: descriptionController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Dosage',
                  ),
                  controller: dosageController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Frequency',
                  ),
                  controller: frequencyController,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    _medications.add(
                      Medication(
                        title: titleController.text,
                        description: descriptionController.text,
                        dosage: dosageController.text,
                        frequency: frequencyController.text,
                      ),
                    );
                    titleController.clear();
                    descriptionController.clear();
                    dosageController.clear();
                    frequencyController.clear();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
