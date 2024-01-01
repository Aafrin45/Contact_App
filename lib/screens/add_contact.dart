// add_contact.dart
import 'package:flutter/material.dart';
import '../model/contact.dart';
import '../repository/contact_repository.dart';

class AddContactPage extends StatefulWidget {
  final ContactRepository contactRepository;

  const AddContactPage({Key? key, required this.contactRepository}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  late TextEditingController nameController;
  late TextEditingController contactController;
  late TextEditingController emailController;

  String? nameError;
  String? contactError;
  String? emailError;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    contactController = TextEditingController();
    emailController = TextEditingController();
  }

  void _addContact() {
    String name = nameController.text.trim();
    String contact = contactController.text.trim();
    String email = emailController.text.trim();

    setState(() {
      nameError = name.isEmpty ? 'Enter a name' : null;
      contactError = contact.isEmpty ? 'Enter a contact number' : null;
      emailError = email.isEmpty ? 'Enter an email' : null;
    });

    if (name.isNotEmpty && contact.isNotEmpty && email.isNotEmpty) {
      Contact newContact = Contact(name: name, contact: contact, email: email);

      if (newContact.isValid()) {
        widget.contactRepository.addContact(newContact);
        Navigator.pop(context, true); // Pass a result to indicate success
      } else {
        // Handle validation errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter valid information')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Contact', style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Contact Name',
                errorText: nameError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                prefixIcon: Icon(Icons.person, size: 20),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Contact Number',
                errorText: contactError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                prefixIcon: Icon(Icons.phone, size: 20),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                errorText: emailError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                prefixIcon: Icon(Icons.email, size: 20),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _addContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.people, size: 20,color: Colors.white),
                    SizedBox(width: 10),
                    Text('Add Contact', style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
