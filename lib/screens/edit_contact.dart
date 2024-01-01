// edit_contact.dart
import 'package:flutter/material.dart';
import '../model/contact.dart';
import '../repository/contact_repository.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;
  final ContactRepository contactRepository;

  const EditContactPage({
    Key? key,
    required this.contact,
    required this.contactRepository,
  }) : super(key: key);

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  late TextEditingController nameController;
  late TextEditingController contactController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.contact.name);
    contactController = TextEditingController(text: widget.contact.contact);
    emailController = TextEditingController(text: widget.contact.email);
  }

  void _saveChanges() {
    String name = nameController.text.trim();
    String contact = contactController.text.trim();
    String email = emailController.text.trim();

    if (name.isNotEmpty && contact.isNotEmpty && email.isNotEmpty) {
      Contact updatedContact = Contact(name: name, contact: contact, email: email);

      if (updatedContact.isValid()) {
        widget.contactRepository.updateContact(widget.contact, updatedContact);
        Navigator.pop(context, true); // Navigate back to the contact list
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
        title: const Text('Edit Contact', style: TextStyle(fontSize: 20, color: Colors.white)),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _saveChanges,
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
                    Icon(Icons.save, size: 20, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Save Changes', style: TextStyle(fontSize: 20, color: Colors.white)),
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
