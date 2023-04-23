import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hvu/medications_widget.dart';
import 'package:hvu/message_screen.dart';
import 'package:hvu/message_widget.dart';
import 'package:hvu/profile_screen.dart';
import 'calendar_page.dart';
import 'add_patient.dart';
import 'navbar.dart';

class LoggedIn extends StatefulWidget {
  LoggedIn({super.key});
  

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  @override

    final List<Map<String, dynamic>> patients = [
    {
      'name': 'John Doe',
      'age': 75,
      'DOB': '1948-01-01',
      'lastMedication': 'Ibuprofen',
      'timeTaken': '2023-04-19 00:00:000',
    },
    {
      'name': 'Jane Smith',
      'age': 68,
      'DOB': '1955-01-01',
      'lastMedication': 'Lozol',
      'timeTaken': '2023-04-19 00:00:000',
    },
    {
      'name': 'Bob Johnson',
      'age': 80,
      'DOB': '1943-01-01',
      'lastMedication': 'Lozol',
      'timeTaken': '2023-04-19 00:00:000',
    },
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Patients'),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (BuildContext context, int index) {
          final patient = patients[index];

          return Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: Text(patient['name'][0]),
                    ),
                    PopupMenuButton<String>(
                        onSelected: (String result) {
                          switch (result) {
                            case 'profile':
                            // link to profile
                            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                              break;
                            case 'schedule':
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CalendarPage()));
                              break;
                            case 'medications':
                              // link to medications
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicationList()));
                              break;
                            case 'message':
                              // link to message
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessageScreen()));
                              break;
                            default:
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'profile',
                                child: Text('Patient Profile'),
                              ),
                               const PopupMenuItem<String>(
                                value: 'schedule',
                                child: Text('Schedule'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'medications',
                                child: Text('Medications'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'message',
                                child: Text('Message'),
                              ),
                            ]),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(patient['name'], style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 8.0),
                Text('Age: ${patient['age']}'),
                SizedBox(height: 8.0),
                Text('DOB: ${patient['DOB']}'),
                SizedBox(height: 8.0),
                Text(
                    'Last Medication: ${patient['lastMedication']} At ${patient['timeTaken']}'),
                SizedBox(height: 16.0),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPatientPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}