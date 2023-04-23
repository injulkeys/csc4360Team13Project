import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final _controller = TextEditingController();
  String _selectedRecipient = 'Patient';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send a message:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Enter your message here',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recipient:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    DropdownButton<String>(
                      value: _selectedRecipient,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRecipient = newValue!;
                        });
                      },
                      items: <String>['Patient', 'Relative', 'Doctor']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    // Send the message using the selected recipient and the text in the text field.
                    print(
                        'Message sent to $_selectedRecipient: ${_controller.text}');
                  },
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
