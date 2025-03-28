import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: ForgotPassword(),
      ),
    ),
  );
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedQuestion;
  String _answer = '';

  final List<String> securityQuestions = [
    "What is your pet's name?",
    "How many points do you have?",
    "How many hint counts have you used?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select a security question:'),
              DropdownButtonFormField<String>(
                value: _selectedQuestion,
                items: securityQuestions.map((String question) {
                  return DropdownMenuItem<String>(
                    value: question,
                    child: Text(question),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedQuestion = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a question' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Your Answer'),
                onChanged: (value) {
                  setState(() {
                    _answer = value;
                  });
                },
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an answer' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement verification logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing your request...')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
