import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hvu/medications_widget.dart';
import 'package:hvu/navbar.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
       debugShowCheckedModeBanner: false,
      title: 'Patient Profile',
       home: PatientProfilePage(
        dob: '12/24/2004',
        patientName: 'John Doe',
        phoneNumber: '890-779-5789',
        gender: 'male',
      ),
    );
  }
}

class PatientProfilePage extends StatelessWidget {
  final String patientName;
  final String gender;
  final String dob;
  final String phoneNumber;

  const PatientProfilePage({
    Key? key,
    required this.patientName,
    required this.gender,
    required this.dob,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Patient Profile'),
      ),

       backgroundColor: Colors.blueGrey[50],
     
      body:
      Column(
        children: [
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              patientName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
                ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gender: $gender', style: const TextStyle(fontSize: 13)),
                Text('Date of Birth: $dob', style: const TextStyle(fontSize: 13)),
                Text('Phone Number: $phoneNumber', style: const TextStyle(fontSize: 13)),
              ],
           ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientSummaryPage(
                            patientName: patientName,
                            gender: gender,
                            dob: dob,
                            phoneNumber: phoneNumber,
                            insuranceDetail: 'Aetna',
                            knownAllergies: 'Soy',
                            officeNumber: '234-867-8901',
                            primaryCarePhysician: 'Dr.Deep',
                          ),
                        ),
                      );
                    },
                    child: const Text('Patient summary'),
                  ),
                ),
              ),
              const SizedBox(width: 55),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicationList(
                          ),
                        ),
                      );
                    },
                    child: const Text('Medication list'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
                const SizedBox(height: 16),
      const SizedBox(height: 16),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Emergency Contact',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: const Text('Name: Doe Joh'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Relation: Father'),
                        onTap: () {},
                      ),
                      const ListTile(
                        title: Text('Cell phone: 123-456-7892'),
                      ),
                      const ListTile(
                        title: Text('Work phone: 345-678-1295'),
                      ),
                      const ListTile(
                        title: Text('Address: 123 Main St, New York, NY 10001'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Emergency Contact'),
          ),
        ),
      ),

              ],
            ),
    );
  }
}

class PatientSummaryPage extends StatelessWidget {
  final String patientName;
  final String gender;
  final String dob;
  final String phoneNumber;
  final String primaryCarePhysician;
  final String officeNumber;
  final String insuranceDetail;
  final String knownAllergies;

  const PatientSummaryPage({
    Key? key,
    required this.patientName,
    required this.gender,
    required this.dob,
    required this.phoneNumber,
    required this.primaryCarePhysician,
    required this.officeNumber,
    required this.insuranceDetail,
    required this.knownAllergies,
  }) : super(key: key);

  Future<void> _printContent() async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        return await Printing.convertHtml(
          format: format,
          html:
              '<html><body><h1>Patient Summary</h1><p>Name: $patientName</p><p>Gender: $gender, DOB: $dob, Phone: $phoneNumber</p><p>Primary Care Physician: $primaryCarePhysician, Office Number: $officeNumber</p><p>Insurance Details: $insuranceDetail</p><p>Known Allergies: $knownAllergies</p></body></html>',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Summary'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printContent,
          ),
        ],
      ),
      body: Column(children: [
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            patientName,
            style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          subtitle:
              Text('Gender: $gender, DOB: $dob, Phone: $phoneNumber'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.medical_services),
          title: const Text(
            'Primary Care Physician',
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(primaryCarePhysician),
          trailing: Text(officeNumber),
          onTap: () {
            // Implement primary care physician
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.medical_services),
          title: const Text(
            'Insurance Details',
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(insuranceDetail),
          onTap: () {
            // Implement insurance details page
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.warning),
          title: const Text(
            'Known Allergies',
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(knownAllergies),
          onTap: () {
            // Implement known allergies page
          },
        ),
      ]),

      
    );
    
  }
  
}
